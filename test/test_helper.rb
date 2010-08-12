require 'rubygems'

require 'rails'
require 'bundler'

require 'shoulda'
require 'mocha'

$:.unshift File.dirname(__FILE__) + '/../lib'

require 'mactag'

class ActiveSupport::TestCase
  setup do
    Mactag.stubs(:warn)
  end
end
