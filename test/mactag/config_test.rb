require 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  
  should "have correct default options" do
    assert_equal "ctags -o TAGS -e", Mactag::Config.binary
    assert_equal "/usr/lib/ruby/gems/1.8/gems", Mactag::Config.gem_home
  end
  
end
