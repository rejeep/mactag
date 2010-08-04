require 'test_helper'

class GemTest < ActiveSupport::TestCase
  setup do
    Mactag::Config.stubs(:gem_home).returns('GEM_HOME')
  end
  
  context '#tag' do
    context 'for existing gem' do
      context 'with no specified version' do
        setup do
          Mactag::Tag::Gem.stubs(:most_recent).returns('devise-1.1.1')

          @gem = Mactag::Tag::Gem.new('devise')
          @gem.stubs(:exists?).returns(true)
        end

        should 'return correct tag' do
          assert_equal 'GEM_HOME/devise-1.1.1/lib/**/*.rb', @gem.tag
        end
      end

      context 'with specified version' do
        setup do
          @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
          @gem.stubs(:exists?).returns(true)
        end

        should 'return correct tag' do
          assert_equal 'GEM_HOME/devise-1.1.1/lib/**/*.rb', @gem.tag
        end
      end
    end

    should 'return nil when gem does not exist' do
      @gem = Mactag::Tag::Gem.new('devise')
      @gem.stubs(:exists?).returns(false)

      assert_nil @gem.tag
    end
  end

  context '#most_recent' do
    should 'return most recent gem if more than one version of same gem exists' do
      Dir.stubs(:glob).returns(['vendor/plugins/devise-1.1.1', 'vendor/plugins/devise-1.1.0'])

      assert_equal 'devise-1.1.1', Mactag::Tag::Gem.most_recent('devise')
    end

    should 'return only gem if only one version of same gem exists' do
      Dir.stubs(:glob).returns(['vendor/plugins/devise-1.1.1'])

      assert_equal 'devise-1.1.1', Mactag::Tag::Gem.most_recent('devise')
    end

    should 'return nil if no version of gem' do
      Dir.stubs(:glob).returns([])

      assert_nil Mactag::Tag::Gem.most_recent('devise')
    end
  end

  context '#exists' do
    context 'with specified version' do
      setup do
        @gem = Mactag::Tag::Gem.new('devise', '1.1.1')
      end

      should 'return true when gem exists' do
        File.stubs(:directory?).returns(true)

        assert @gem.send(:exists?)
      end

      should 'return false when gem does not exist' do
        File.stubs(:directory?).returns(false)

        assert !@gem.send(:exists?)
      end
    end

    context 'with no specified version' do
      setup do
        @gem = Mactag::Tag::Gem.new('devise')
      end

      should 'return true when gem exists' do
        Mactag::Tag::Gem.stubs(:most_recent).returns('devise-1.1.1')

        assert @gem.send(:exists?)
      end

      should 'return false when gem does not exist' do
        Mactag::Tag::Gem.stubs(:most_recent).returns(nil)

        assert !@gem.send(:exists?)
      end
    end
  end

  context '#splash' do
    should 'return gem name, dash, version' do
      @gem = Mactag::Tag::Gem.new('devise', '1.1.1')

      assert_equal 'devise-1.1.1', @gem.send(:splash)
    end
  end
end
