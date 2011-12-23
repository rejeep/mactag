require 'spec_helper'

describe Mactag::Config do
  context 'configuration options' do
    it "should have option 'binary'" do
      Mactag::Config.should respond_to(:binary)
      Mactag::Config.should respond_to(:binary=)
    end

    it "should have option 'tags_file'" do
      Mactag::Config.should respond_to(:tags_file)
      Mactag::Config.should respond_to(:tags_file=)
    end

    it "should have option 'rvm'" do
      Mactag::Config.should respond_to(:rvm)
      Mactag::Config.should respond_to(:rvm=)
    end

    it "should have option 'gem_home'" do
      Mactag::Config.should respond_to(:gem_home)
      Mactag::Config.should respond_to(:gem_home=)
    end
  end

  it 'should be configurable' do
    Mactag.configure do |config|
      config.should == Mactag::Config
    end
  end

  it "requires '{INPUT}' and '{OUTPUT}' in binary string" do
    proc {
      Mactag.configure do |config|
        config.binary = 'ctags -o {foo} -e {bar}'
      end
    }.should raise_exception
  end
end
