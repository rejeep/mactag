require 'spec_helper'

describe Mactag::Indexer::Plugin do
  subject do
    Mactag::Indexer::Plugin.new('devise')
  end

  it_should_behave_like 'indexer'

  before do
    @plugin = Mactag::Indexer::Plugin.new('devise')
  end

  it 'has correct plugin path' do
    Mactag::Indexer::Plugin::PLUGIN_PATH.should == ['vendor', 'plugins']
  end

  describe '#tag' do
    it 'returns path to plugin when plugin exists' do
      @plugin.stub(:exist?) { true }
      @plugin.tag.should == 'vendor/plugins/devise/lib/**/*.rb'
    end

    it 'raises exception when plugin does not exist' do
      @plugin.stub(:exist?) { false }
      proc {
        @plugin.tag
      }.should raise_exception(Mactag::PluginNotFoundError)
    end
  end

  describe '#exist?' do
    it 'is true when plugin directory exists' do
      File.stub(:directory?) { true }
      @plugin.should exist
    end

    it 'is false when plugin directory does not exist' do
      File.stub(:directory?) { false }
      @plugin.should_not exist
    end
  end

  describe '#path' do
    it 'return path to plugin' do
      @plugin.path.should == 'vendor/plugins/devise'
    end
  end

  describe '#all' do
    it 'returns empty array when no plugins' do
      Dir.stub(:glob) { [] }

      all = Mactag::Indexer::Plugin.all
      all.should be_empty
    end

    it 'returns plugin name when single plugin' do
      Dir.stub(:glob) { ['vendor/plugins/devise'] }
      
      all = Mactag::Indexer::Plugin.all
      all.map(&:name).should == ['devise']
    end

    it 'returns plugin names when multiple plugins' do
      Dir.stub(:glob) {
        [
         'vendor/plugins/devise',
         'vendor/plugins/simple_form'
        ]
      }
      
      all = Mactag::Indexer::Plugin.all
      all.map(&:name).should =~ ['devise', 'simple_form']
    end
  end
end
