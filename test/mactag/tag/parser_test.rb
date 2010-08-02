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

    context 'none' do
      setup do
        Mactag::Tag::Plugin.stubs(:all).returns(['devise'])

        @parser.plugin
      end

      should 'have correct tag' do
        assert_equal 'vendor/plugins/devise/lib/**/*.rb', tags.first.tag
      end
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

  context 'gem' do
    setup do
      Mactag::Config.stubs(:gem_home).returns('GEM_HOME')
      File.stubs(:directory?).returns(true)
    end

    context 'none' do
      setup do
        Mactag::Tag::Gem.stubs(:all).returns([gem('devise', '1.1.1')])

        @parser.gem
      end

      should 'have correct tag' do
        assert_equal 'GEM_HOME/devise-1.1.1/lib/**/*.rb', tags.last.tag
      end
    end

    context 'does not exist' do
      setup do
        File.stubs(:directory?).returns(false)

        @parser.gem('typo')
      end

      should 'have correct tag' do
        assert_nil tags.last.tag
      end
    end

    context 'single' do
      context 'with version' do
        setup do
          @parser.gem('devise', :version =>'0.8.7')
        end

        should 'have correct tag' do
          assert_equal 'GEM_HOME/devise-0.8.7/lib/**/*.rb', tags.last.tag
        end
      end

      context 'without version' do
        setup do
          @parser.gem('devise')
        end

        should 'have correct tag' do
          gem = tags.first
          gem.stubs(:latest).returns('devise-1.1.1')
          
          assert_equal 'GEM_HOME/devise-1.1.1/lib/**/*.rb', tags.last.tag
        end
      end
    end

    context 'multiple' do
      setup do
        @parser.gem('devise', 'rack')
      end

      should 'have correct tag' do
        devise = tags.first
        devise.stubs(:latest).returns('devise-1.1.1')
        assert_equal 'GEM_HOME/devise-1.1.1/lib/**/*.rb', devise.tag

        rack = tags.first
        rack.stubs(:latest).returns('rack-1.2.1')
        assert_equal 'GEM_HOME/rack-1.2.1/lib/**/*.rb', rack.tag
      end
    end
  end


  private

  def tags
    Mactag::Table.class_variable_get('@@tags')
  end

  def gem(name, version)
    Mactag::Tag::Gem.new(name, version)
  end
end
