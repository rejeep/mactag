require 'spec_helper'

describe Mactag::Dsl do
  before do
    @dsl = Mactag::Dsl.new(Mactag::Builder.new)
  end

  describe '#app' do
    it_supports_dsl 'without arguments' do
      @dsl.index(:app)
    end

    it_supports_dsl 'with single argument' do
      @dsl.index('lib/foo.rb')
    end

    it_supports_dsl 'with multiple arguments' do
      @dsl.index('lib/foo.rb', 'app/models/*.rb')
    end
  end

  describe '#gems' do
    before do
      Mactag::Tag::Gem.stub(:all) do
        [Mactag::Tag::Gem.new('devise', '1.1.1')]
      end
    end

    it_supports_dsl ':gems' do
      @dsl.index(:gems)
    end

    context 'with single gem' do
      it_supports_dsl 'without version' do
        @dsl.index('devise')
      end

      it_supports_dsl 'with version' do
        @dsl.index('devise', :version => '1.1.1')
      end
    end

    context 'with multiple gems' do
      it_supports_dsl 'without version' do
        @dsl.index('devise', 'rack')
      end

      it_does_not_support_dsl 'with version' do
        @dsl.index('devise', 'rack', :version => '1.1.1')
      end
    end
  end

  describe '#rails' do
    context 'without version' do
      it_supports_dsl 'without arguments' do
        @dsl.index(:rails)
      end

      it_supports_dsl 'with packages only' do
        @dsl.index(:rails, :only => [])
      end

      it_supports_dsl 'with packages except' do
        @dsl.index(:rails, :except => [])
      end
    end

    context 'with version' do
      it_supports_dsl do
        @dsl.index(:rails, :version => '3.0.0')
      end

      it_supports_dsl 'with only' do
        @dsl.index(:rails, :version => '3.0.0', :only => [])
      end

      it_supports_dsl 'with except' do
        @dsl.index(:rails, :version => '3.0.0', :except => [])
      end
    end

    it_does_not_support_dsl 'with only and except' do
      @dsl.index(:rails, :only => [], :except => [])
    end
  end

  context 'deprecated' do
    describe '#plugin' do
      before do
        Mactag::Tag::Plugin.stub(:all) do
          [Mactag::Tag::Plugin.new('devise')]
        end
      end

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
  end
end
