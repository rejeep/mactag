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
end
