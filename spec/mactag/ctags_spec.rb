require 'spec_helper'

describe Mactag::Ctags do
  before do
    Mactag::Config.stub!(:binary).and_return('ctags -o {OUTPUT} -e {INPUT}')

    @ctags = Mactag::Ctags.new('in', 'out')
    @ctags.stub!(:exec)
  end

  describe '#create' do
    it 'should execute command' do
      @ctags.should_receive(:exec).with('ctags -o out -e in')
      @ctags.create
    end
  end

  describe '#command' do
    it 'should return the correct command' do
      Rails.stub!(:root).and_return('root')

      @ctags.send(:command, 'bin').should == 'cd root && bin'
    end
  end

  context 'input files' do
    it 'should handle single file' do
      @ctags = Mactag::Ctags.new('in', 'out')
      @ctags.instance_variable_get('@input').should =~ ['in']
    end

    it 'should handle multiple files' do
      @ctags = Mactag::Ctags.new(['in_1', 'in_2'], 'out')
      @ctags.instance_variable_get('@input').should =~ ['in_1', 'in_2']
    end
  end
end
