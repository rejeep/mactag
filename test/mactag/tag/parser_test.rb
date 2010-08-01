require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  def setup
    Mactag::Table.class_variable_set('@@tags', [])
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

  context 'plugin' do
    setup do
      @plugin = 'funland'
      @parser.app(@plugin)
    end

    should 'have correct tag' do
      assert_equal 'funland', tags.first.tag
    end
  end

  context 'all plugins' do
    setup do
      @parser = Mactag::Tag::Parser.new(nil)
    end

    context 'with existing plugins' do
      setup do
        Dir.stubs(:glob).returns(['plugin/one', 'plugin/two'])
      end

      should 'return only plugin names' do
        assert_same_elements @parser.send(:all_plugins), ['one', 'two']
      end
    end

    context 'with no existing plugins' do
      setup do
        Dir.stubs(:glob).returns([])
      end

      should 'return only plugin names' do
        assert_same_elements @parser.send(:all_plugins), []
      end
    end
  end


  private

  def tags
    Mactag::Table.class_variable_get('@@tags')
  end
end
