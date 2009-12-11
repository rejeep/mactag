require 'test_helper'

class AppTest < ActiveSupport::TestCase

  context "an app tag" do
    setup do
      @tags = [ "app/**/*.rb", "public/javascripts/*.js" ]
      @app = Mactag::Tag::App.new(@tags)
    end

    should "return the correct files" do
      assert_same_elements [@tags], @app.files
    end
  end

end
