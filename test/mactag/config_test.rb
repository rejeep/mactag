require 'test_helper'

class ConfigTest < ActiveSupport::TestCase
  context '#binary' do
    should 'be right command' do
      assert_equal 'ctags -o TAGS -e', Mactag::Config.binary
    end
  end

  context '#gem_home' do
    context 'when using RVM' do
      setup do
        Mactag::Config.stubs(:rvm).returns(true)
        File.stubs(:join).returns('/path/to/rvm/gems')

        @gem_home = Mactag::Config.gem_home
      end

      should 'be correct' do
        assert_equal '/path/to/rvm/gems', @gem_home
      end
    end

    context 'when not using RVM' do
      setup do
        Mactag::Config.stubs(:rvm).returns(false)

        @gem_home = Mactag::Config.gem_home
      end

      should 'correct' do
        assert_equal '/Library/Ruby/Gems/1.8/gems', @gem_home
      end
    end
  end
end
