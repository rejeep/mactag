require 'spec_helper'

describe Mactag::Tag::App do
  subject do
    Mactag::Tag::App.new('app')
  end

  it_should_behave_like 'tagger'
end
