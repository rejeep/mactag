require 'spec_helper'

describe Mactag::Tag::Plugin do
  it 'should have correct plugin path' do
    Mactag::Tag::Plugin::PLUGIN_PATH.should == 'vendor/plugins'
  end

  describe '#tag' do
    before do
      @plugin = Mactag::Tag::Plugin.new('devise')
    end

    it 'should return tag when plugin exist' do
      @plugin.stub!(:exists?).and_return(true)

      @plugin.tag.should == 'vendor/plugins/devise/lib/**/*.rb'
    end

    it 'should return nil when plugin does not exist' do
      @plugin.stub!(:exists?).and_return(false)

      @plugin.tag.should be_nil
    end
  end

  describe '#exists' do
    before do
      @plugin = Mactag::Tag::Plugin.new('devise')
    end

    it 'should be true when plugin exist' do
      File.stub!(:directory?).and_return(true)

      @plugin.send(:exists?).should be_true
    end

    it 'should be false when plugin does not exist' do
      File.stub!(:directory?).and_return(false)

      @plugin.send(:exists?).should be_false
    end
  end

  describe '#all' do
    it 'return plugins when they exist' do
      Dir.stub!(:glob).and_return(['plugin/one', 'plugin/two'])

      Mactag::Tag::Plugin.all.should =~ ['one', 'two']
    end

    it 'return empty array when no plugins exist' do
      Dir.stub!(:glob).and_return([])

      Mactag::Tag::Plugin.all.should be_empty
    end
  end
end
