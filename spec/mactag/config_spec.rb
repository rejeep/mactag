require 'spec_helper'

describe Mactag::Config do
  describe '#binary' do
    it 'should have correct command' do
      Mactag::Config.binary.should == 'ctags -o {OUTPUT} -e {INPUT}'
    end
  end
  
  describe '#tags_file' do
    it 'should have correct name' do
      Mactag::Config.tags_file.should == 'TAGS'
    end
  end

  describe '#gem_home' do
    context 'when using RVM' do
      before do
        Mactag::Config.stub!(:rvm).and_return(true)
        File.stub!(:join).and_return('/path/to/rvm/gems')
      end

      it 'should be the correct gems path' do
        Mactag::Config.gem_home.should == '/path/to/rvm/gems'
      end
    end

    context 'when not using RVM' do
      before do
        Mactag::Config.stub!(:rvm).and_return(false)
      end

      it 'should be the default gem path' do
        Mactag::Config.gem_home.should == '/Library/Ruby/Gems/1.8/gems'
      end
    end
  end

  describe '#rvm' do
    it 'should be true by default' do
      Mactag::Config.rvm.should be_true
    end
  end
  
  describe '#tags_dir' do
    it 'should have correct name' do
      Mactag::Config.tags_dir.should == '.tags'
    end
  end
end
