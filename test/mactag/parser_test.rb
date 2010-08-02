require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  setup do
    @parser = Mactag::Parser.new(Mactag::Builder)
  end

  context 'app' do
    should 'be able to handle single argument' do
      @parser.app('lib/**/*.rb')
    end
  end

  context 'plugin' do
    should 'be able to handle no arguments' do
      @parser.plugin
    end

    should 'be able to handle single argument' do
      @parser.plugin('devise')
    end

    should 'be able to handle multiple arguments' do
      @parser.plugins('devise', 'rack')
    end
  end

  context 'gem' do
    should 'be able to handle no arguments' do
      @parser.gem
    end

    context 'single argument' do
      should 'be able to handle version' do
        @parser.gem('devise', :version => '1.1.1')
      end

      should 'be able to handle no version' do
        @parser.gem('devise')
      end
    end

    should 'be able to handle multiple arguments' do
      @parser.gem('devise', 'rack')
    end
  end

  context 'rails' do
    should 'be able to handle no arguments' do
      @parser.rails
    end

    should 'be able to handle only' do
      @parser.rails(:only => [])
    end

    should 'be able to handle except' do
      @parser.rails(:except => [])
    end

    should 'be able to handle version' do
      @parser.rails(:version => '3.0.0.rc')
    end
  end
end
