require 'spec_helper'

describe Mactag do
  it 'should respond to #rails_app?' do
    Mactag.should respond_to(:rails_app?)
  end
  
  it 'should respond to #rails_version' do
    Mactag.should respond_to(:rails_version)
  end
  
  it 'should respond to #project_root' do
    Mactag.should respond_to(:project_root)
  end
  
  it 'should respond to #project_name' do
    Mactag.should respond_to(:project_name)
  end
end
