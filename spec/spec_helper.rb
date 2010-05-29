begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'ruby-beamer'

def printed   
    @printed || ""
end

def print(*args)
    @printed = args.inject(printed){|p, s| p + s}
    nil
end
