require 'spec_helper'

describe Mactag::Dsl do
  before do
    @builder = Mactag::Builder.new
    @dsl = Mactag::Dsl.new(@builder)
  end

  describe '#app' do
    it_should_support_dsl 'single argument' do
      @dsl.app('lib/**/*.rb')
    end
  end

  describe '#plugin' do
    it_should_support_dsl 'without arguments' do
      @dsl.plugin
    end

    it_should_support_dsl 'single argument' do
      @dsl.plugin('devise')
    end

    it_should_support_dsl 'multiple arguments' do
      @dsl.plugins('devise', 'rack')
    end
  end

  describe '#gem' do
    it_should_support_dsl 'without arguments' do
      @dsl.gem
    end

    context 'single argument' do
      it_should_support_dsl 'with version' do
        @dsl.gem('devise', :version => '1.1.1')
      end

      it_should_support_dsl 'without version' do
        @dsl.gem('devise')
      end
    end

    it_should_support_dsl 'multiple arguments' do
      @dsl.gem('devise', 'rack')
    end
  end

  describe '#rails' do
    it_should_support_dsl 'without arguments' do
      @dsl.rails
    end

    it_should_support_dsl 'packages only' do
      @dsl.rails(:only => [])
    end

    it_should_support_dsl 'packages except' do
      @dsl.rails(:except => [])
    end

    it_should_support_dsl 'with version' do
      @dsl.rails(:version => '3.0.0.rc')
    end
  end
end
