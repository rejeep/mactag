require 'test_helper'

class BuilderTest < ActiveSupport::TestCase
  setup do
    @builder = Mactag::Builder.new
  end

  context '#<<' do
    setup do
      @tag = Mactag::Tag::App.new('app')
    end

    should 'add single tag to tags' do
      @builder << @tag

      assert_equal 1, @builder.instance_variable_get('@tags').size
    end

    should 'add multiple tags to tags' do
      @builder << [@tag, @tag]

      assert_equal 2, @builder.instance_variable_get('@tags').size
    end
  end

  context '#all' do
    should 'return all tags if existing tags' do
      app = Mactag::Tag::App.new('app')
      lib = Mactag::Tag::App.new('lib')

      @builder << app
      @builder << lib

      assert_same_elements ['app', 'lib'], @builder.all
    end

    should 'return an empty array if no tags' do
      assert_same_elements [], @builder.all
    end
  end

  context '#gems?' do
    should 'return true if existing tags' do
      @builder.stubs(:all).returns(['app'])

      assert @builder.gems?
    end

    should 'return false if no existing tags' do
      @builder.stubs(:all).returns([])

      assert !@builder.gems?
    end
  end

  context '#generate' do
    should 'accept a block as argument' do
      assert_nothing_raised do
        Mactag::Builder.generate {}
      end
    end
  end

  context '#gem_home_exists?' do
    should 'exist if directory exists in system' do
      File.stubs(:directory?).returns(true)

      assert Mactag::Builder.gem_home_exists?
    end

    should 'not exist if directory does not exist in system' do
      File.stubs(:directory?).returns(false)

      assert !Mactag::Builder.gem_home_exists?
    end
  end
end
