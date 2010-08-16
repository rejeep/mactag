require 'spec_helper'

describe Mactag::Tag::Gem do
  before do
    Mactag::Config.stub!(:gem_home).and_return('GEM_HOME')
  end

  describe '#tag' do
    context 'for existing gem' do
      context 'with no specified version' do
        before do
          Mactag::Tag::Gem.stub!(:most_recent).and_return('devise-1.1.1')

          @gem = Mactag::Tag::Gem.new('devise')
          @gem.stub!(:exists?).and_return(true)
        end

        it 'return correct tag' do
          @gem.tag.should == 'GEM_HOME/devise-1.1.1/lib/**/*.rb'
        end
      end

      context 'with specified version' do
        before do
          @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
          @gem.stub!(:exists?).and_return(true)
        end

        it 'return correct tag' do
          @gem.tag.should == 'GEM_HOME/devise-1.1.1/lib/**/*.rb'
        end
      end
    end

    it 'return nil when gem does not exist' do
      @gem = Mactag::Tag::Gem.new('devise')
      @gem.stub!(:exists?).and_return(false)

      @gem.tag.should be_nil
    end
  end

  describe '#most_recent' do
    it 'should return most recent gem if more than one version of same gem exists' do
      Dir.stub!(:glob).and_return(['vendor/plugins/devise-1.1.1', 'vendor/plugins/devise-1.1.0'])

      Mactag::Tag::Gem.most_recent('devise').should == 'devise-1.1.1'
    end

    it 'should return only gem if only one version of same gem exists' do
      Dir.stub!(:glob).and_return(['vendor/plugins/devise-1.1.1'])

      Mactag::Tag::Gem.most_recent('devise').should == 'devise-1.1.1'
    end

    it 'should return nil if no version of gem' do
      Dir.stub!(:glob).and_return([])

      Mactag::Tag::Gem.most_recent('devise').should be_nil
    end
  end

  describe '#exists' do
    context 'with specified version' do
      before do
        @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
      end

      it 'should be true when gem exist' do
        File.stub!(:directory?).and_return(true)

        @gem.send(:exists?).should be_true
      end

      it 'should be false when gem does not exist' do
        File.stub!(:directory?).and_return(false)

        @gem.send(:exists?).should be_false
      end
    end

    context 'with no specified version' do
      before do
        @gem = Mactag::Tag::Gem.new('devise')
      end

      it 'should be true when gem exists' do
        Mactag::Tag::Gem.stub!(:most_recent).and_return('devise-1.1.1')

        @gem.send(:exists?).should be_true
      end

      it 'should be false when gem does not exist' do
        Mactag::Tag::Gem.stub!(:most_recent).and_return(nil)

        @gem.send(:exists?).should be_false
      end
    end
  end

  describe '#splash' do
    before do
      @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
    end

    it 'return gem name, dash, version' do
      @gem.send(:splash).should == 'devise-1.1.1'
    end
  end
end
