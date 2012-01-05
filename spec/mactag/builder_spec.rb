require 'spec_helper'

describe Mactag::Builder do
  before do
    @builder = Mactag::Builder.new
  end

  describe '#<<' do
    before do
      @tag = Mactag::Indexer::App.new('app')
    end

    it 'adds single tag' do
      @builder << @tag

      @builder.tags.should =~ [@tag]
    end

    it 'adds multiple tags' do
      @builder << [@tag, @tag]

      @builder.tags.should =~ [@tag, @tag]
    end
  end

  describe '#files' do
    before do
      Dir.stub(:glob) { |file| [file] }
      File.stub(:expand_path) { |file| file }
      File.stub(:directory?) { false }
    end

    it 'flattens all files' do
      @builder.stub(:all) { [['app'], 'lib'] }
      @builder.files.should =~ ['app', 'lib']
    end

    it 'compacts all files' do
      @builder.stub(:all) { [nil, 'app', nil, 'lib', nil] }
      @builder.files.should =~ ['app', 'lib']
    end

    it 'expands all files' do
      @builder.stub(:all) { ['app', 'lib'] }
      File.should_receive(:expand_path).with('app')
      File.should_receive(:expand_path).with('lib')
      @builder.files
    end

    it 'globs all files' do
      @builder.stub(:all) { ['app', 'lib'] }
      Dir.should_receive(:glob).with('app')
      Dir.should_receive(:glob).with('lib')
      @builder.files
    end

    it 'uniquifies files' do
      @builder.stub(:all) { ['app', 'lib', 'lib', 'app'] }
      @builder.files.should == ['app', 'lib']
    end

    it 'does not return directories' do
      @builder.stub(:all) { ['app'] }
      Dir.stub(:glob) { ['app'] }
      File.stub(:directory?) { true }
      @builder.files.should be_empty
    end
  end

  describe '#directories' do
    it 'returns all file dirnames' do
      @builder.stub(:files) { ['app/models/user.rb', 'lib/validate.rb'] }
      @builder.directories.should =~ ['app/models', 'lib']
    end

    it 'returns uniq directories' do
      @builder.stub(:files) { ['app/models/user.rb', 'app/models/post.rb'] }
      @builder.directories.should =~ ['app/models']
    end
  end

  describe '#all' do
    it 'returns all files' do
      @builder << Mactag::Indexer::App.new('app')
      @builder << Mactag::Indexer::App.new('lib')

      @builder.all.should =~ ['app', 'lib']
    end

    it 'returns empty array when no tags' do
      @builder.all.should be_empty
    end
  end

  describe '#gems?' do
    it 'is true when tags exists' do
      @builder.stub(:all) { ['app'] }

      @builder.should have_gems
    end

    it 'is false when no tags exists' do
      @builder.stub(:all) { [] }

      @builder.should_not have_gems
    end
  end

  describe '#create' do
    it 'raises error when gem home does not exist' do
      Mactag::Builder.stub(:gem_home_exists?) { false }
      proc {
        Mactag::Builder.create
      }.should raise_exception(Mactag::MactagError)
    end

    it 'raises errors when gem home exists but there are no gems' do
      Mactag::Builder.stub(:gem_home_exists?) { true }
      Mactag::Builder.stub(:builder) { mock(:has_gems? => false) }
      proc {
        Mactag::Builder.create
      }.should raise_exception(Mactag::MactagError)
    end
  end

  describe '#generate' do
    it 'accepts a block as argument' do
      proc {
        Mactag::Builder.generate {}
      }.should_not raise_exception
    end
  end

  describe '#gem_home_exists?' do
    it 'exists when directory exists' do
      File.stub(:directory?) { true }

      Mactag::Builder.gem_home_exists?.should be_true
    end

    it 'does not exist when directory does not exist' do
      File.stub!(:directory?).and_return(false)

      Mactag::Builder.gem_home_exists?.should be_false
    end
  end

  describe '#builder' do
    it 'returns builder instance' do
      Mactag::Builder.generate {}
      Mactag::Builder.builder.should == Mactag::Builder.instance_variable_get('@builder')
    end
  end
end
