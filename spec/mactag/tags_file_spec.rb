require 'spec_helper'

describe Mactag::TagsFile do
  before do
    File.stub!(:join).and_return('_path_to.file.rb')

    @tags_file = Mactag::TagsFile.new('file')
  end

  describe '#delete' do
    it 'should delete output file' do
      File.should_receive(:delete).with(@tags_file.instance_variable_get('@output'))

      @tags_file.delete
    end
  end

  describe 'exists?' do
    it 'should exist when file exists' do
      File.stub!(:exists?).and_return(true)

      @tags_file.exist?.should be_true
    end

    it 'should not exist when file does not exist' do
      File.stub!(:exists?).and_return(false)

      @tags_file.exist?.should be_false
    end
  end

  describe '#output' do
    it 'return correct output file' do
      File.stub!(:join).and_return { |*args| args.last }

      @tags_file.send(:output, '/path/to/file.rb').should == '_path_to_file.rb'
    end
  end
end
