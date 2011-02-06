require 'spec_helper'

describe Mactag::Tag::Plugin do
  subject do
    Mactag::Tag::Plugin.new('devise')
  end
  
  before do
    @plugin = Mactag::Tag::Plugin.new('devise')
  end

  it_should_behave_like 'tagger'

  it 'has correct plugin path' do
    Mactag::Tag::Plugin::PLUGIN_PATH.should eq(['vendor', 'plugins'])
  end

  describe '#tag' do
    it 'returns path to plugin when plugin exists' do
      @plugin.stub(:exists?) { true }
      @plugin.tag.should eq('vendor/plugins/devise/lib/**/*.rb')
    end

    it 'raises exception when plugin does not exist' do
      @plugin.stub(:exists?) { false }
      proc {
        @plugin.tag
      }.should raise_exception(Mactag::PluginNotFoundError)
    end
  end

  describe '#path' do
    it 'return path to plugin' do
      @plugin.path.should eq('vendor/plugins/devise')
    end
  end

  describe '#exists?' do
    it 'is true when plugin directory exists' do
      File.stub(:directory?) { true }
      @plugin.exists?.should be_true
    end

    it 'is false when plugin directory does not exist' do
      File.stub(:directory?) { false }
      @plugin.exists?.should be_false
    end
  end

  describe '#all' do
    it 'returns empty array when no plugins' do
      Dir.stub(:glob) { [] }
      Mactag::Tag::Plugin.all.should be_empty
    end

    it 'returns plugin name when single plugin' do
      Dir.stub(:glob) { ['vendor/plugins/devise'] }
      Mactag::Tag::Plugin.all.should eq(['devise'])
    end

    it 'returns plugin names when multiple plugins' do
      Dir.stub(:glob) {
        ['vendor/plugins/devise', 'vendor/plugins/simple_form']
      }
      Mactag::Tag::Plugin.all.should eq(['devise', 'simple_form'])
    end
  end
end
