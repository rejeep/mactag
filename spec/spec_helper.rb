require 'rubygems'
require 'rails'
require 'bundler'
require 'rspec'

require 'mactag'
require 'custom_macros'

RSpec.configure do |config|
  config.include CustomMacros
  
  config.before do
    Mactag::Config.stub(:gem_home) { 'GEM_HOME' }
  end
end

shared_examples_for 'tagger' do
  it 'responds to tag' do
    subject.should respond_to(:tag)
  end
end
