require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  def setup
    @parser = Mactag::Tag::Parser.new(Mactag::Table)
  end

  context 'app' do
    setup do
      @tag = 'lib/**/*.rb'
      @parser.app(@tag)
    end

    should 'have correct tag' do
      assert_equal 'lib/**/*.rb', tags.first.tag
    end
  end


  private

  def tags
    Mactag::Table.class_variable_get('@@tags')
  end
end
