require 'spec_helper'

describe Mactag::Server do
  describe '#create_tags_dir' do
    it 'should create directory when not exists' do
      File.stub!(:directory?).and_return(false)
      Dir.should_receive(:mkdir).with(Mactag::Config.tags_dir)

      Mactag::Server.send(:create_tags_dir)
    end

    it 'should not create directory when already exists' do
      File.stub!(:directory?).and_return(true)
      Dir.should_not_receive(:mkdir)

      Mactag::Server.send(:create_tags_dir)
    end
  end

  describe '#clear_tags' do
    it 'should clear files when files' do
      Dir.stub!(:glob).and_return(['file.rb', 'temp.rb'])
      File.should_receive(:delete).with('file.rb')
      File.should_receive(:delete).with('temp.rb')

      Mactag::Server.send(:clear_tags)
    end

    it 'should not clear files when no files' do
      Dir.stub!(:glob).and_return([])
      File.should_not_receive(:delete)

      Mactag::Server.send(:clear_tags)
    end
  end
end
