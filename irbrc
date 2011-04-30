# Put this content to ~/.irbrc file (no extension)

require "rubygems"

begin
  require "ap"
rescue LoadError => err
  puts "Cannot find awesome_print gem. Please run 'gem install awesome_print' to install it."
end

begin
  require "wirble"

  Wirble::Colorize.colors.merge!(
    :object_class => :black,
    :class        => :dark_gray,
    :symbol       => :red,
    :symbol_prefix=> :blue
  )

  Wirble.init
  Wirble.colorize
rescue LoadError => err
  puts "Cannot find wirble. Please run 'gem install wirble' to install it."
end

begin
  require 'looksee'

  Looksee.styles.merge!(
    :module => "\e[1;34m%s\e[0m" # purple
  )
rescue LoadError
  puts "Cannot find looksee. Please run 'gem install looksee' to install it."
end

# Rails on-screen logging

def change_log(stream)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.clear_active_connections!
end

def show_log
  change_log(STDOUT)

  puts "SQL log enabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end

def hide_log
  change_log(nil)

  puts "SQL log disabled. Enter 'reload!' to reload all loaded ActiveRecord classes"
end

# Simple benchmarking

def time(times = 1)
  require 'benchmark'

  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end

# IRB configuration reloading

def IRB.reload
  load __FILE__
end

# SQL query execution

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

# Hirb

if ENV['RAILS_ENV']
  begin
    require 'hirb'
    Hirb.enable
  rescue LoadError
    puts "Error loading Hirb. Run 'sudo gem install hirb'"
  end
end
