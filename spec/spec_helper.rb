require 'rubygems'
require 'rails'
require 'bundler'
require 'rspec'

require 'mactag'
require 'custom_macros'

RSpec.configure do |config|
  config.before do
    Mactag.stub!(:warn)
  end

  config.include CustomMacros
end
