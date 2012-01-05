require 'spec_helper'

describe Mactag::Indexer::Gem do
  subject do
    Mactag::Indexer::Gem.new('devise')
  end

  it_should_behave_like 'indexer'

  before do
    @gem = Mactag::Indexer::Gem.new('devise')
    
    Mactag::Config.stub(:gem_home) { 'GEM_HOME' }
  end

  describe '#tag' do
    context 'when gem exists' do
      before do
        @gem.stub(:exist?) { true }
      end

      context 'without version' do
        before do
          @gem.stub(:most_recent) { '1.1.1' }
        end

        it 'returns path to gem' do
          @gem.tag.should == 'GEM_HOME/devise-1.1.1/lib/**/*.rb'
        end
      end

      context 'with version' do
        before do
          @gem.stub(:version) { '1.1.1' }
        end

        it 'returns path to gem' do
          @gem.tag.should == 'GEM_HOME/devise-1.1.1/lib/**/*.rb'
        end
      end
    end

    context 'when gem does not exist' do
      before do
        @gem.stub(:exist?) { false }
      end

      it 'raises exception' do
        proc {
          @gem.tag
        }.should raise_exception(Mactag::GemNotFoundError)
      end
    end
  end

  describe '#exist?' do
    it 'exists when single version of gem exists' do
      @gem.stub(:dirs) { ['GEM_HOME/devise-1.1.1/lib/**/*.rb'] }
      @gem.should exist
    end

    it 'exists when more than one version of gem exists' do
      @gem.stub(:dirs) {
        [
         'GEM_HOME/devise-1.1.0/lib/**/*.rb',
         'GEM_HOME/devise-1.1.1/lib/**/*.rb'
        ]
      }
      @gem.should exist
    end

    it 'does not exist when no gem exist' do
      @gem.stub(:dirs) { [] }
      @gem.should_not exist
    end
  end

  describe '#version' do
    it 'should return version when specified' do
      gem = Mactag::Indexer::Gem.new('devise', '1.1.1')
      gem.version.should == '1.1.1'
    end
    
    it 'should return most recent version when not specified' do
      gem = Mactag::Indexer::Gem.new('devise')
      gem.stub(:most_recent) { '1.1.1' }
      gem.version.should == '1.1.1'
    end
  end

  describe '#most_recent' do
    context 'when no gems exists' do
      before do
        @gem.stub(:dirs) { [] }
      end

      it 'should be nil' do
        @gem.most_recent.should be_nil
      end
    end

    context 'when single version of gem exist' do
      before do
        @gem.stub(:dirs) { ['GEM_HOME/devise-1.1.1/lib/**/*.rb'] }
      end

      it 'should extract version' do
        @gem.most_recent.should == '1.1.1'
      end
    end

    context 'when multiple versions of gem exist' do
      before do
        @gem.stub(:dirs) {
          [
           'GEM_HOME/devise-1.1.0/lib/**/*.rb',
           'GEM_HOME/devise-1.1.1/lib/**/*.rb'
          ]
        }
      end

      it 'should extract the most recent version' do
        @gem.most_recent.should == '1.1.1'
      end
    end

    context 'when gem name includes regex keywords' do
      before do
        @gem = Mactag::Indexer::Gem.new('foo+bar')
        @gem.stub(:dirs) { ['GEM_HOME/foo+bar-0.0.1/lib/**/*.rb'] }
      end

      it 'should extract version' do
        @gem.most_recent.should == '0.0.1'
      end
    end

    context 'when gem version is not on the form MAJOR.MINOR.PATCH' do
      before do
        @gem.stub(:dirs) { ['GEM_HOME/devise-2.0.0.rc/lib/**/*.rb'] }
      end

      it 'should extract version' do
        @gem.most_recent.should == '2.0.0.rc'
      end
    end

    context 'when the path contains other version numbers' do
      before do
        @gem.stub(:dirs) { ['/Users/user/.rvm/gems/ree-1.8.7-2011.03@project/gems/devise-1.1.2'] }
      end

      it 'should extract version' do
        @gem.most_recent.should == '1.1.2'
      end
    end
  end

  context '#dirs' do
    it 'should escape gem name' do
      Dir.should_receive(:glob).with('GEM_HOME/devise-*')

      @gem.dirs
    end
  end

  context 'self#all' do
    before do
      Mactag::Bundler.stub(:gems) { [['devise', '1.1.1']] }
    end

    it 'should return all as gems' do
      all = Mactag::Indexer::Gem.all

      gem = all.first
      gem.name.should == 'devise'
      gem.version.should == '1.1.1'
    end
  end
end
