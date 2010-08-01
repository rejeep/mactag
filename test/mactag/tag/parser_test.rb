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
      File.stubs(:directory?).returns(true)
    end

    context 'single' do
      setup do
        @parser.plugin('rack')
      end

      should 'have correct tag' do
        assert_equal 'vendor/plugins/rack/lib/**/*.rb', tags.first.tag
      end
    end

    context 'multiple' do
      setup do
        @parser.plugin('bundler', 'rake')
      end

      should 'have correct tag' do
        assert_equal 'vendor/plugins/bundler/lib/**/*.rb', tags.first.tag
        assert_equal 'vendor/plugins/rake/lib/**/*.rb', tags.last.tag
      end
    end
  end


  private

  def tags
    Mactag::Table.class_variable_get('@@tags')
  end
end
