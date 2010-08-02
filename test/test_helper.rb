require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_support/core_ext'

require 'shoulda'
require 'mocha'

$:.unshift File.dirname(__FILE__) + '/../lib'
require 'mactag'

module Mactag
  def self.warn(message)
    # TODO: Why can this method no be stubbed?
  end
end
