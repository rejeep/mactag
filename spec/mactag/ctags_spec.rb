require 'spec_helper'

describe Mactag::Ctags do
  before do
    @ctags = Mactag::Ctags.new('in', 'out')
  end

  describe '#initialize' do
    it 'handles a single file' do
      @ctags = Mactag::Ctags.new('in', 'out')
      @ctags.input.should =~ ['in']
    end

    it 'handles multiple files' do
      @ctags = Mactag::Ctags.new(['in_1', 'in_2'], 'out')
      @ctags.input.should =~ ['in_1', 'in_2']
    end
  end

  describe '#command' do
    before do
      Mactag.stub(:project_root) { 'root' }

      @ctags.stub(:binary) { 'binary' }
    end

    it 'is correct command' do
      @ctags.send(:command).should == 'cd root && binary'
    end
  end

  describe '#binary' do
    before do
      Mactag::Config.stub(:binary) { 'ctags -o {OUTPUT} -e {INPUT}' }
    end

    it 'returns correct command' do
      @ctags.send(:binary).should == 'ctags -o out -e in'
    end
  end
end
