begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'ruby-beamer'

include RubyBeamer

module RubyBeamer
    def printed
        @printed || ""
    end

    def output(*args)
        @printed = args.inject(printed){|p, s| p + s}
        nil
    end

    def get_beamer_hash(*args)
        return args.to_beamer_hash
    end
end
