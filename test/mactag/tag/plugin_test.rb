require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  should 'have correct plugin path' do
    assert_equal 'vendor/plugins', Mactag::Tag::Plugin::PLUGIN_PATH
  end

  context 'existing plugin' do
    setup do
      File.stubs(:directory?).returns(true)

      @plugin = Mactag::Tag::Plugin.new('thinking-sphinx')
    end

    should 'return the path to that plugin' do
      assert_equal 'vendor/plugins/thinking-sphinx/lib/**/*.rb', @plugin.tag
    end
  end

  context 'non existing plugin' do
    setup do
      File.stubs(:directory?).returns(false)

      @plugin = Mactag::Tag::Plugin.new('typo')
    end

    should 'return no tag' do
      assert_nil @plugin.tag
    end
  end

  context '#all' do
    context 'with existing plugins' do
      setup do
        Dir.stubs(:glob).returns(['plugin/one', 'plugin/two'])
      end

      should 'return only plugin names' do
        assert_same_elements Mactag::Tag::Plugin.all, ['one', 'two']
      end
    end

    context 'with no existing plugins' do
      setup do
        Dir.stubs(:glob).returns([])
      end

      should 'return only plugin names' do
        assert_same_elements Mactag::Tag::Plugin.all, []
      end
    end
  end
end
