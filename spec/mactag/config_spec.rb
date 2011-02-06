require 'spec_helper'

describe Mactag::Config do
  describe '#binary' do
    it 'is correct command' do
      Mactag::Config.binary.should eq('ctags -o {OUTPUT} -e {INPUT}')
    end
  end

  describe '#tags_file' do
    it 'is correct name' do
      Mactag::Config.tags_file.should eq('TAGS')
    end
  end

  describe '#gem_home' do
    context 'when using RVM' do
      before do
        Mactag::Config.stub(:rvm) { true }
        File.stub(:join) { '/path/to/rvm/gems' }
      end

      it 'is the correct gems path' do
        Mactag::Config.gem_home.should eq('/path/to/rvm/gems')
      end
    end

    context 'when not using RVM' do
      before do
        Mactag::Config.stub(:rvm) { false }
      end

      it 'is the default gem path' do
        Mactag::Config.gem_home.should eq('/Library/Ruby/Gems/1.8/gems')
      end
    end
  end

  describe '#rvm' do
    it 'is true by default' do
      Mactag::Config.rvm.should be_true
    end
  end
end
