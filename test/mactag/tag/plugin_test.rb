require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  should 'have correct plugin path' do
    assert_equal 'vendor/plugins', Mactag::Tag::Plugin::PLUGIN_PATH
  end

  context 'with no arguments' do
    setup do
      @plugin = Mactag::Tag::Plugin.new
    end

    should 'return all plugins as path' do
      assert_equal @plugin.files, 'vendor/plugins/*/lib/**/*.rb'
    end
  end

  context 'with single plugin' do
    setup do
      File.stubs(:exist?).returns(true)

      @plugin = Mactag::Tag::Plugin.new('thinking-sphinx')
    end

    should 'return the path to that plugin' do
      assert_same_elements ['vendor/plugins/thinking-sphinx/lib/**/*.rb'], @plugin.files
    end
  end

  context 'with multiple plugins' do
    setup do
      File.stubs(:exist?).returns(true)

      @plugin = Mactag::Tag::Plugin.new('thinking-sphinx', 'formtastic')
    end

    should 'return the paths to those plugins' do
      assert_same_elements @plugin.files, [
                                           'vendor/plugins/thinking-sphinx/lib/**/*.rb',
                                           'vendor/plugins/formtastic/lib/**/*.rb'
                                          ]
    end
  end

  context 'plugin that does not exist' do
    setup do
      File.stubs(:exist?).returns(false)

      @plugin = Mactag::Tag::Plugin.new('typo')
    end

    should 'not raise exception because no such plugin' do
      assert_nothing_raised do
        assert_same_elements [], @plugin.files
      end
    end
  end
end
