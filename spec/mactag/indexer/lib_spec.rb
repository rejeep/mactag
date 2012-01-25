require 'spec_helper'

describe Mactag::Indexer::Lib do
  subject do
    Mactag::Indexer::Lib.new('lib')
  end

  it_should_behave_like 'indexer'

  context 'self#all' do
    it 'should return all files' do
      all = Mactag::Indexer::Lib.all
      all.map(&:tag).should =~ Mactag::Indexer::Lib::PATTERNS
    end
  end

  it 'should have ruby files in lib as default pattern' do
    Mactag::Indexer::Lib::PATTERNS.should =~ ['lib/**/*.rb']
  end
end
