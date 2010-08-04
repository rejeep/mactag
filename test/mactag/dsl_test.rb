require 'test_helper'

class DslTest < ActiveSupport::TestCase
  setup do
    @builder = Mactag::Builder.new
    @dsl = Mactag::Dsl.new(@builder)
  end

  context 'app' do
    should 'be able to handle single argument' do
      @dsl.app('lib/**/*.rb')
    end
  end

  context 'plugin' do
    should 'be able to handle no arguments' do
      @dsl.plugin
    end

    should 'be able to handle single argument' do
      @dsl.plugin('devise')
    end

    should 'be able to handle multiple arguments' do
      @dsl.plugins('devise', 'rack')
    end
  end

  context 'gem' do
    should 'be able to handle no arguments' do
      @dsl.gem
    end

    context 'single argument' do
      should 'be able to handle version' do
        @dsl.gem('devise', :version => '1.1.1')
      end

      should 'be able to handle no version' do
        @dsl.gem('devise')
      end
    end

    should 'be able to handle multiple arguments' do
      @dsl.gem('devise', 'rack')
    end
  end

  context 'rails' do
    should 'be able to handle no arguments' do
      @dsl.rails
    end

    should 'be able to handle only' do
      @dsl.rails(:only => [])
    end

    should 'be able to handle except' do
      @dsl.rails(:except => [])
    end

    should 'be able to handle version' do
      @dsl.rails(:version => '3.0.0.rc')
    end
  end
end
