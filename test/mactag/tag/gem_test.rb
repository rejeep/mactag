require 'test_helper'

class GemTest < ActiveSupport::TestCase
  
  context "gem with version" do
    setup do
      @gem = Mactag::Tag::Gem.new("thinking-sphinx", :version => "1.0.0")
    end
    
    should "return the gem with that version" do
      assert_contains @gem.files, File.join(Mactag::Config.gem_home, "thinking-sphinx-1.0.0", "**", "*.rb")
    end
  end
  
end
