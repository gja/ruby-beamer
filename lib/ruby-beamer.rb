$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module RubyBeamer
  VERSION = '0.0.1'
end

require 'ruby-beamer/constants'
require 'ruby-beamer/common'
require 'ruby-beamer/create-beamer-doc'
require 'ruby-beamer/beamer'
