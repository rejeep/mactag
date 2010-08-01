require 'test_helper'

class AppTest < ActiveSupport::TestCase
  context 'application tag' do
    setup do
      @tag = 'app/**/*.rb'
      @app = Mactag::Tag::App.new(@tag)
    end

    should 'return the same file as array' do
      assert_same_elements [@tag], @app.files
    end
  end
end
