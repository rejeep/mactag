require 'spec_helper'

describe Mactag::Builder do
  before do
    @builder = Mactag::Builder.new
  end

  describe '#<<' do
    before do
      @tag = Mactag::Tag::App.new('app')
    end

    it 'should add single tag' do
      @builder << @tag

      @builder.instance_variable_get('@tags').should =~ [@tag]
    end

    it 'should add multiple tags' do
      @builder << [@tag, @tag]

      @builder.instance_variable_get('@tags').should =~ [@tag, @tag]
    end
  end

  describe '#tags' do
    before do
      Dir.stub!(:glob).and_return { |file| file }
      File.stub!(:expand_path).and_return { |file| file }
    end

    it 'should flatten all tags' do
      @builder.stub!(:all).and_return([['app'], 'lib'])
      @builder.tags.should =~ ['app', 'lib']
    end

    it 'should compact all tags' do
      @builder.stub!(:all).and_return([nil, 'app', nil, 'lib', nil])
      @builder.tags.should =~ ['app', 'lib']
    end

    it 'should expand all tags' do
      @builder.stub!(:all).and_return(['app', 'lib'])
      File.should_receive(:expand_path).with('app')
      File.should_receive(:expand_path).with('lib')
      @builder.tags
    end

    it 'should glob all tags' do
      @builder.stub!(:all).and_return(['app', 'lib'])
      Dir.should_receive(:glob).with('app')
      Dir.should_receive(:glob).with('lib')
      @builder.tags
    end

    it 'should uniquify tags' do
      @builder.stub!(:all).and_return(['app', 'lib', 'lib', 'app'])
      @builder.tags.should =~ ['app', 'lib']
    end
  end

  describe '#all' do
    it 'should return all tags' do
      @builder << Mactag::Tag::App.new('app')
      @builder << Mactag::Tag::App.new('lib')

      @builder.all.should =~ ['app', 'lib']
    end

    it 'should return empty array when no tags' do
      @builder.all.should be_empty
    end
  end

  describe '#gems?' do
    it 'should be true when tags exists' do
      @builder.stub!(:all).and_return(['app'])

      @builder.gems?.should be_true
    end

    it 'should be false when no tags exists' do
      @builder.stub!(:all).and_return([])

      @builder.gems?.should be_false
    end
  end

  describe '#generate' do
    it 'should accept a block as argument' do
      lambda { Mactag::Builder.generate {} }.should_not raise_exception
    end
  end

  describe '#gem_home_exists?' do
    it 'should exist when directory exists' do
      File.stub!(:directory?).and_return(true)

      Mactag::Builder.gem_home_exists?.should be_true
    end

    it 'should not exist when directory does not exist' do
      File.stub!(:directory?).and_return(false)

      Mactag::Builder.gem_home_exists?.should be_false
    end
  end
end
