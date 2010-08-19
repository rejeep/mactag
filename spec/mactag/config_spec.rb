require 'spec_helper'

describe Mactag::Config do
  describe '#binary' do
    it 'should be the right command' do
      Mactag::Config.binary.should == 'ctags -o TAGS -e'
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

  describe '#fssm' do
    it 'should be false by default' do
      Mactag::Config.fssm.should be_false
    end

    it 'should return default tags dir when true' do
      Mactag::Config.fssm = true
      Mactag::Config.fssm.should == '.tags'
    end

    it 'should return correct tags dir when set' do
      Mactag::Config.fssm = 'tags'
      Mactag::Config.fssm.should == 'tags'
    end
  end
end
