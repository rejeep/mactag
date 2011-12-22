require 'spec_helper'

describe Mactag::Tag::App do
  subject do
    Mactag::Tag::App.new('app')
  end
  
  it_should_behave_like 'tagger'
  
  it 'should return all files' do
    Mactag::Tag::App.all.map(&:tag).should =~ Mactag::Tag::App::PATTERNS
  end
end
