require 'test_helper'

class GemTest < ActiveSupport::TestCase
  def setup
    File.stubs(:directory?).returns(true)
  end
  
  context 'gem with version' do
    setup do
      Mactag::Config.stubs(:gem_home).returns('GEM_HOME')

      @gem = Mactag::Tag::Gem.new('thinking-sphinx', :version => '1.0.0')
    end

    should 'return the gem with that version' do
      assert_contains @gem.files, File.join('GEM_HOME', 'thinking-sphinx-1.0.0', 'lib', '**', '*.rb')
    end
  end

  context 'gem without version' do
    context 'single gem' do
      setup do
        Dir.stubs(:glob).returns(['whenever-0.3.7'])

        @gem = Mactag::Tag::Gem.new('whenever')
      end

      should 'return that gem' do
        assert_contains @gem.files, File.join('whenever-0.3.7', 'lib', '**', '*.rb')
      end
    end

    context 'multiple gems' do
      setup do
        Dir.stubs(:glob).returns(['whenever-0.3.7', 'whenever-0.3.6'])

        @gem = Mactag::Tag::Gem.new('whenever')
      end

      should 'return the gem with the latest version' do
        assert_contains @gem.files, File.join('whenever-0.3.7', 'lib', '**', '*.rb')
        assert_does_not_contain @gem.files, File.join('whenever-0.3.6', 'lib', '**', '*.rb')
      end
    end
  end

  context 'gem that does not exist' do
    setup do
      Dir.stubs(:glob).returns([])
      File.stubs(:directory?).returns(false)

      @gem = Mactag::Tag::Gem.new('whenever')
    end

    should 'not raise exception because no such gem' do
      assert_nothing_raised do
        assert_equal [], @gem.files
      end
    end
  end
end
