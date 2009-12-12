require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  
  should "have correct plugin path" do
    assert_equal "vendor/plugins", Mactag::Tag::Plugin::PLUGIN_PATH
  end
  
  context "without arguments" do
    setup do
      @plugin = Mactag::Tag::Plugin.new
    end

    should "return all plugins as path" do
      assert_equal @plugin.files, "vendor/plugins/*/lib/**/*.rb"
    end
  end
  
  context "with one plugin argument" do
    setup do
      @plugin = Mactag::Tag::Plugin.new("thinking-sphinx")
    end
    
    should "return the path to that plugin" do
      assert_equal ["vendor/plugins/thinking-sphinx/lib/**/*.rb"], @plugin.files
    end
  end
  
  context "with more thatn one plugin argument" do
    setup do
      @plugin = Mactag::Tag::Plugin.new("thinking-sphinx", "formtastic")
    end
    
    should "return the paths to those plugins" do
      assert_contains @plugin.files, "vendor/plugins/thinking-sphinx/lib/**/*.rb"
      assert_contains @plugin.files, "vendor/plugins/formtastic/lib/**/*.rb"
    end
  end
  
end
