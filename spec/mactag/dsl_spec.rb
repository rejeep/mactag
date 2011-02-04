require 'spec_helper'

describe Mactag::Dsl do
  before do
    @dsl = Mactag::Dsl.new(Mactag::Builder.new)
  end

  describe '#app' do
    it_does_not_support_dsl 'without arguments' do
      @dsl.app
    end

    it_supports_dsl 'with single argument' do
      @dsl.app('lib/**/*.rb')
    end

    it_supports_dsl 'with multiple arguments' do
      @dsl.app('lib/**/*.rb', 'app/**/*.rb')
    end
  end

  describe '#plugin' do
    it_supports_dsl 'without arguments' do
      @dsl.plugin
    end

    it_supports_dsl 'with single argument' do
      @dsl.plugin('devise')
    end

    it_supports_dsl 'with multiple arguments' do
      @dsl.plugins('devise', 'rack')
    end
  end

  describe '#gem' do
    it_supports_dsl 'without arguments' do
      @dsl.gem
    end

    context 'with single argument' do
      it_supports_dsl 'without version' do
        @dsl.gem('devise')
      end

      it_supports_dsl 'with version' do
        @dsl.gem('devise', :version => '1.1.1')
      end
    end

    context 'with multiple arguments' do
      it_supports_dsl 'without version' do
        @dsl.gem('devise', 'rack')
      end

      it_does_not_support_dsl 'with version' do
        @dsl.gem('devise', 'rack', :version => '1.1.1')
      end
    end
  end

  describe '#rails' do
    it_supports_dsl 'without arguments' do
      @dsl.rails
    end

    it_supports_dsl 'with packages only' do
      @dsl.rails(:only => [])
    end

    it_supports_dsl 'with packages except' do
      @dsl.rails(:except => [])
    end

    context 'with version' do
      it_supports_dsl do
        @dsl.rails(:version => '3.0.0')
      end

      it_supports_dsl 'with only' do
        @dsl.rails(:version => '3.0.0', :only => [])
      end

      it_supports_dsl 'with except' do
        @dsl.rails(:version => '3.0.0', :except => [])
      end
    end

    it_does_not_support_dsl 'with only and except' do
      @dsl.rails(:only => [], :except => [])
    end
  end
end
