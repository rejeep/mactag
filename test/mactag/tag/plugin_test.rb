require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  should 'have correct plugin path' do
    assert_equal 'vendor/plugins', Mactag::Tag::Plugin::PLUGIN_PATH
  end

  context '#tag' do
    setup do
      @plugin = Mactag::Tag::Plugin.new('devise')
    end

    should 'return correct tag when plugin exists' do
      @plugin.stubs(:exists?).returns(true)

      assert_equal 'vendor/plugins/devise/lib/**/*.rb', @plugin.tag
    end

    should 'return nil when plugin does not exist' do
      @plugin.stubs(:exists?).returns(false)

      assert_nil @plugin.tag
    end
  end

  context '#exists' do
    setup do
      @plugin = Mactag::Tag::Plugin.new('devise')
    end

    should 'return true when plugin exists' do
      File.stubs(:directory?).returns(true)
      
      assert @plugin.exists?
    end

    should 'return false when plugin does not exist' do
      File.stubs(:directory?).returns(false)
      
      assert !@plugin.exists?
    end
  end

  context '#all' do
    should 'return plugins when they exists' do
      Dir.stubs(:glob).returns(['plugin/one', 'plugin/two'])

      assert_same_elements Mactag::Tag::Plugin.all, ['one', 'two']
    end

    should 'return an empty array when no plugins exist' do
      Dir.stubs(:glob).returns([])

      assert_same_elements Mactag::Tag::Plugin.all, []
    end
  end
end
