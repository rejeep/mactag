require 'spec_helper'

describe Mactag::Config do
  before(:all) do
    @binary, @tags_file, @rvm, @gem_home =
    %w(binary tags_file rvm gem_home).map do |option|
      Mactag::Config.instance_variable_get("@#{option}")
    end
  end

  after do
    Mactag::Config.binary = @binary
    Mactag::Config.tags_file = @tags_file
    Mactag::Config.rvm = @rvm
    Mactag::Config.gem_home = @gem_home
  end

  describe '.binary' do
    it "should have option 'binary'" do
      Mactag::Config.binary.should == @binary
      Mactag::Config.should respond_to(:binary)
      Mactag::Config.should respond_to(:binary=)
    end

    it "requires '{INPUT}' and '{OUTPUT}' to be present" do
      proc {
        Mactag::Config.binary = 'ctags -o {foo} -e {bar}'
      }.should raise_exception
    end
  end

  context '.tags_file' do
    it "should have option 'tags_file'" do
      Mactag::Config.tags_file.should == @tags_file
      Mactag::Config.should respond_to(:tags_file)
      Mactag::Config.should respond_to(:tags_file=)
    end
  end

  context '.rvm' do
    it "should have option 'rvm'" do
      Mactag::Config.rvm.should == true
      Mactag::Config.should respond_to(:rvm)
      Mactag::Config.should respond_to(:rvm=)
    end

    it "should be true or false" do
      proc {
        Mactag::Config.rvm = 'true'
      }.should raise_exception
    end
  end

  context '.gem_home' do
    it "should have option 'gem_home'" do
      Mactag::Config.should respond_to(:gem_home)
      Mactag::Config.should respond_to(:gem_home=)
    end

    it 'should be default when not using RVM' do
      Mactag::Config.rvm = false
      Mactag::Config.gem_home.should == @gem_home
    end

    it 'should be gem homet when using RVM' do
      File.stub(:join) { 'GEM_HOME' }

      Mactag::Config.rvm = true
      Mactag::Config.gem_home.should == 'GEM_HOME'
    end
  end

  it 'should be configurable block style' do
    Mactag.configure do |config|
      config.binary = 'binary {INPUT} {OUTPUT}'
      config.tags_file = 'tags_file'
      config.rvm = false
      config.gem_home = 'gem_home'
    end

    Mactag::Config.binary.should == 'binary {INPUT} {OUTPUT}'
    Mactag::Config.tags_file.should == 'tags_file'
    Mactag::Config.rvm.should == false
    Mactag::Config.gem_home.should == 'gem_home'
  end
end
