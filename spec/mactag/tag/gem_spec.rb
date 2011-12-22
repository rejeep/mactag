require 'spec_helper'

describe Mactag::Tag::Gem do
  subject do
    Mactag::Tag::Gem.new('devise')
  end

  it_should_behave_like 'tagger'

  before do
    @gem = Mactag::Tag::Gem.new('devise')
  end

  describe '#tag' do
    context 'when gem exists' do
      before do
        @gem.stub(:exists?) { true }
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
        @gem.stub(:exists?) { false }
      end

      it 'raises exception' do
        proc {
          @gem.tag
        }.should raise_exception(Mactag::GemNotFoundError)
      end
    end
  end

  describe '#exists?' do
    context 'without version' do
      it 'is true when single version of gem exists' do
        Dir.stub(:glob) { ['devise-1.1.1'] }
        @gem.exists?.should be_true
      end

      it 'is true when multiple versions of gem exists' do
        Dir.stub(:glob) { %w(devise-1.1.0 devise-1.1.1) }
        @gem.exists?.should be_true
      end

      it 'is false when gem does not exist' do
        Dir.stub(:glob) { [] }
        @gem.exists?.should be_false
      end
    end
  end

  describe '#most_recent' do
    before do
      @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
    end

    context 'when no gems exists' do
      before do
        @gem.stub(:dirs) { [] }
      end

      it 'returns nil' do
        @gem.most_recent.should be_nil
      end
    end

    context 'when single version of gem exist' do
      before do
        @gem.stub(:dirs) { ['devise-1.1.1'] }
      end

      it 'returns nil' do
        @gem.most_recent.should == '1.1.1'
      end
    end

    context 'when multiple versions of gem exist' do
      before do
        @gem.stub(:dirs) { ['devise-1.1.0', 'devise-1.1.1'] }
      end

      it 'returns nil' do
        @gem.most_recent.should == '1.1.1'
      end
    end

    context 'when the path contains other version numbers' do
      before do
        @gem.stub(:dirs) { ['/Users/user/.rvm/gems/ree-1.8.7-2011.03@project/gems/devise-1.1.2'] }
      end

      it 'extract correct version' do
        @gem.most_recent.should == '1.1.2'
      end
    end
  end
end
