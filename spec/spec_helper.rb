require 'rubygems'
require 'rails'
require 'bundler'
require 'rspec'

require 'mactag'

require 'matcher'

RSpec.configure do |config|
  config.include Matcher
end

shared_examples_for 'indexer' do
  it 'responds to #tag' do
    subject.should respond_to(:tag)
  end
end
