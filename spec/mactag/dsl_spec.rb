require 'spec_helper'

describe Mactag::Dsl do
  before do
    @dsl = Mactag::Dsl.new(Mactag::Builder.new)
  end

  context 'deprecated API' do
    before do
      $stderr.stub(:puts)
    end

    describe '#app' do
      it '#index should receive :app when no arguments' do
        @dsl.should_receive(:index).with(:app)
        @dsl.app
      end

      it '#index should receive argument when single arguments' do
        @dsl.should_receive(:index).with('foo.rb')
        @dsl.app('foo.rb')
      end

      it '#index should receive arguments when many arguments' do
        @dsl.should_receive(:index).with('foo.rb', 'bar.rb')
        @dsl.app('foo.rb', 'bar.rb')
      end
    end

    describe '#gems' do
      it '#index should receive :gems when no arguments' do
        @dsl.should_receive(:index).with(:gems)
        @dsl.gems
      end

      it '#index should receive gem name when single gem' do
        @dsl.should_receive(:index).with('devise')
        @dsl.gems('devise')
      end

      it '#index should receive gem name and version when single gem with version' do
        @dsl.should_receive(:index).with('devise', '1.1.1')
        @dsl.gems('devise', '1.1.1')
      end

      it '#index should receive gem names when multiple gems' do
        @dsl.should_receive(:index).with('devise', 'simple_form')
        @dsl.gems('devise', 'simple_form')
      end

      it '#index should receive gems and version when multiple gems and version' do
        @dsl.should_receive(:index).with('devise', 'simple_form', { :version => '1.1.1' })
        @dsl.gems('devise', 'simple_form', :version => '1.1.1')
      end
    end

    describe '#rails' do
      it '#index should receive :rails when no options' do
        @dsl.should_receive(:index).with(:rails)
        @dsl.rails
      end

      it '#index should receive version when version' do
        @dsl.should_receive(:index).with({ :version => '3.0.0' })
        @dsl.rails(:version => '3.0.0')
      end

      it '#index should receive package when only and single package' do
        @dsl.should_receive(:index).with({ :only => 'activerecord' })
        @dsl.rails(:only => 'activerecord')
      end

      it '#index should receive packages when only and many package' do
        @dsl.should_receive(:index).with({ :only => ['activerecord', 'activemodel'] })
        @dsl.rails(:only => ['activerecord', 'activemodel'])
      end

      it '#index should receive package when except and single package' do
        @dsl.should_receive(:index).with({ :except => 'activerecord' })
        @dsl.rails(:except => 'activerecord')
      end

      it '#index should receive packages when except and many package' do
        @dsl.should_receive(:index).with({ :except => ['activerecord', 'activemodel'] })
        @dsl.rails(:except => ['activerecord', 'activemodel'])
      end

      it '#index should receive options when mix' do
        @dsl.should_receive(:index).with({ :only => ['activerecord', 'activemodel'], :version => '3.0.0' })
        @dsl.rails(:only => ['activerecord', 'activemodel'], :version => '3.0.0')
      end
    end
  end

  describe '#app' do
    it 'should index default when :app' do
      @dsl.index(:app)
      @dsl.should have_app_index(*Mactag::Indexer::App::PATTERNS)
    end

    it 'should index argument' do
      @dsl.index('lib/foo.rb')
      @dsl.should have_app_index('lib/foo.rb')
    end

    it 'should index arguments' do
      @dsl.index('lib/foo.rb', 'app/models/*.rb')
      @dsl.should have_app_index('lib/foo.rb', 'app/models/*.rb')
    end
  end

  describe '#gems' do
    it 'should index all gems when :gems' do
      Mactag::Indexer::Gem.stub(:all) do
        [
         Mactag::Indexer::Gem.new('devise', '1.1.1'),
         Mactag::Indexer::Gem.new('simple_form', '1.5.4')
        ]
      end

      @dsl.index(:gems)
      @dsl.should have_gem_index('devise', '1.1.1')
      @dsl.should have_gem_index('simple_form', '1.5.4')
    end

    it 'should index single gem without version' do
      Mactag::Indexer::Gem.stub(:exist?) { true }

      @dsl.index('devise')
      @dsl.should have_gem_index('devise')
    end

    it 'should index single gem with version' do
      Mactag::Indexer::Gem.stub(:exist?) { true }

      @dsl.index('devise', :version => '1.1.1')
      @dsl.should have_gem_index('devise', '1.1.1')
    end

    it 'should index multiple gems' do
      Mactag::Indexer::Gem.stub(:exist?) { true }

      @dsl.index('devise', 'simple_form')
      @dsl.should have_gem_index('devise')
      @dsl.should have_gem_index('simple_form')
    end

    it 'should index when mix' do
      Mactag::Indexer::Gem.stub(:exist?) { true }

      @dsl.index('devise', :version => '1.1.1')
      @dsl.index('simple_form')
      @dsl.should have_gem_index('devise', '1.1.1')
      @dsl.should have_gem_index('simple_form')
    end

    it 'should raise exception when more than one gem specified with version' do
      proc {
        @dsl.index('devise', 'simple_form', :version => '1.1.1')
      }.should raise_exception(ArgumentError)
    end
  end

  describe '#rails' do
    before do
      Mactag.stub(:rails_app?) { true }
    end
    
    it 'should raise exception when indexing :rails and not in a Rails application' do
      Mactag.stub(:rails_app?) { false }
      proc {
        @dsl.index(:rails)
      }.should raise_exception
    end
    
    it 'should index when no options' do
      @dsl.index(:rails)
      @dsl.should have_rails_index('actionmailer', 'actionpack', 'activemodel', 'activerecord', 'activeresource', 'activesupport', 'railties')
    end

    it 'should index when version' do
      @dsl.index(:rails, :version => '3.0.0')
      @dsl.should have_rails_index('actionmailer', 'actionpack', 'activemodel', 'activerecord', 'activeresource', 'activesupport', 'railties', :version => '3.0.0')
    end

    it 'should index when only and single package' do
      @dsl.index(:rails, :only => 'activemodel')
      @dsl.should have_rails_index('activemodel')
    end

    it 'should index when only and many packages' do
      @dsl.index(:rails, :only => ['activerecord', 'activemodel'])
      @dsl.should have_rails_index('activerecord', 'activemodel')
    end

    it 'should index when except and single package' do
      @dsl.index(:rails, :except => 'activemodel')
      @dsl.should have_rails_index('actionmailer', 'actionpack', 'activerecord', 'activeresource', 'activesupport', 'railties')
    end

    it 'should index when except and many packages' do
      @dsl.index(:rails, :except => ['activerecord', 'activemodel'])
      @dsl.should have_rails_index('actionmailer', 'actionpack', 'activeresource', 'activesupport', 'railties')
    end

    it 'should index when mix' do
      @dsl.index(:rails, :only => ['activerecord', 'activemodel'], :version => '3.0.0')
      @dsl.should have_rails_index('activerecord', 'activemodel', :version => '3.0.0')
    end
  end

  context 'deprecated' do
    describe '#plugin' do
      before do
        Mactag::Indexer::Plugin.stub(:all) do
          [Mactag::Indexer::Plugin.new('devise')]
        end
      end

      it 'should index without arguments' do
        @dsl.send(:plugin_private)
        @dsl.should have_plugin_index('devise')
      end

      it 'should index with single argument' do
        @dsl.send(:plugin_private, 'devise')
        @dsl.should have_plugin_index('devise')
      end

      it 'should index with many arguments' do
        @dsl.send(:plugin_private, 'devise', 'rack')
        @dsl.should have_plugin_index('devise', 'rack')
      end
    end
  end
end
