require 'spec_helper'

describe Mactag::Tag::Gem do
  subject do
    Mactag::Tag::Gem.new('devise')
  end

  it_should_behave_like 'tagger'

  before do
    Mactag::Config.stub(:gem_home) { 'GEM_HOME' }

    @gem = Mactag::Tag::Gem.new('devise')
  end

  describe '#tag' do
    context 'when gem exists' do
      before do
        @gem.stub(:exists?) { true }
      end

      context 'without version' do
        before do
          Mactag::Tag::Gem.stub(:last) { '1.1.1' }
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

  describe '#last' do
    context 'when no gems exists' do
      before do
        Mactag::Tag::Gem.stub(:dirs) { [] }
      end

      it 'returns nil' do
        Mactag::Tag::Gem.last('devise').should be_nil
      end
    end

    context 'when single version of gem exist' do
      before do
        Mactag::Tag::Gem.stub(:dirs) { ['devise-1.1.1'] }
      end

      it 'returns nil' do
        Mactag::Tag::Gem.last('devise').should == '1.1.1'
      end
    end

    context 'when multiple versions of gem exist' do
      before do
        Mactag::Tag::Gem.stub(:dirs) { ['devise-1.1.0', 'devise-1.1.1'] }
      end

      it 'returns nil' do
        Mactag::Tag::Gem.last('devise').should == '1.1.1'
      end
    end
    
    context 'when the path contains other version numbers' do
      before do
        Mactag::Tag::Gem.stub(:dirs) { ['/Users/user/.rvm/gems/ree-1.8.7-2011.03@project/gems/simple_form-1.3.1'] }
      end

      it 'extract correct version' do
        Mactag::Tag::Gem.last('simple_form').should == '1.3.1'
      end      
    end
    
  end
end
