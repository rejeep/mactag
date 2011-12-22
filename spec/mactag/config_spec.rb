require 'spec_helper'

describe Mactag::Config do
  it 'should be configurable' do
    Mactag.configure do |config|
      config.rvm = false
      config.binary = 'ctags -o {OUTPUT} -e {INPUT}'
      config.tags_file = 'tags-foo'
      config.gem_home = '/Library/Ruby/Gems/1.9/gems'
    end

    Mactag::Config.binary.should == 'ctags -o {OUTPUT} -e {INPUT}'
    Mactag::Config.tags_file.should == 'tags-foo'
    Mactag::Config.rvm.should be_false
  end
end
