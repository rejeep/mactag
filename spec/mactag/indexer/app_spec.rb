require 'spec_helper'

describe Mactag::Indexer::App do
  subject do
    Mactag::Indexer::App.new('app')
  end

  it_should_behave_like 'indexer'

  context 'self#all' do
    it 'should return all files' do
      all = Mactag::Indexer::App.all
      all.map(&:tag).should =~ Mactag::Indexer::App::PATTERNS
    end
  end

  it 'should have ruby files in app and lib as default pattern' do
    Mactag::Indexer::App::PATTERNS.should =~ ['app/**/*.rb', 'lib/**/*.rb']
  end
end
