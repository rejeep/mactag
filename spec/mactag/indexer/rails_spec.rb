require 'spec_helper'

describe Mactag::Indexer::Rails do
  subject do
    Mactag::Indexer::Rails.new({})
  end

  it_should_behave_like 'indexer'

  before do
    @rails = Mactag::Indexer::Rails.new({})
  end

  it 'should have correct default packages' do
    Mactag::Indexer::Rails::PACKAGES.should == ['actionmailer', 'actionpack', 'activemodel', 'activerecord', 'activeresource', 'activesupport', 'railties']
  end

  context 'packagize' do
    it 'should packagize only' do
      @rails = Mactag::Indexer::Rails.new(:only => ['active_model'])
      @rails.only.should == ['activemodel']
    end

    it 'should packagize except' do
      @rails = Mactag::Indexer::Rails.new(:except => ['active_model', :action_pack])
      @rails.except.should == ['activemodel', 'actionpack']
    end
  end

  describe '#tag' do
    before do
      Mactag::Indexer::Gem.stub(:new) { mock(:tag => 'tag') }
    end

    it 'returns empty array when no packages' do
      @rails.stub(:packages) { [] }
      @rails.tag.should == []
    end

    it 'returns array with gem tags when packages' do
      @rails.stub(:packages) { ['activemodel', 'activerecord'] }
      @rails.tag.should == ['tag', 'tag']
    end
  end

  describe '#packages' do
    it 'should return all packages unless only and except' do
      @rails.packages.should =~ Mactag::Indexer::Rails::PACKAGES
    end

    it 'should return some packages when only specified' do
      @rails = Mactag::Indexer::Rails.new(:only => [:active_support, :activerecord])
      @rails.packages.should =~ ['activesupport', 'activerecord']
    end

    it 'should return some packages when except specified' do
      @rails = Mactag::Indexer::Rails.new(:except => [:active_support, :activerecord])
      @rails.packages.should =~ ['actionmailer', 'actionpack', 'activemodel', 'activeresource', 'railties']
    end
  end

  describe '#packagize' do
    it 'returns empty array when no packages' do
      @rails.send(:packagize, []).should be_nil
    end

    context 'single package' do
      it 'packagizes when symbol' do
        @rails.send(:packagize, [:activerecord]).should =~ ['activerecord']
      end

      it 'packagizes when string' do
        @rails.send(:packagize, ['activerecord']).should =~ ['activerecord']
      end

      it 'packagizes when underscore' do
        @rails.send(:packagize, [:active_record]).should =~ ['activerecord']
      end
    end

    context 'multiples packages' do
      it 'packagizes when symbols' do
        @rails.send(:packagize, [:activerecord, :activemodel]).should =~ ['activerecord', 'activemodel']
      end

      it 'packagizes when string' do
        @rails.send(:packagize, ['activerecord', 'activemodel']).should =~ ['activerecord', 'activemodel']
      end

      it 'packagizes when underscore' do
        @rails.send(:packagize, [:active_record, :active_model]).should =~ ['activerecord', 'activemodel']
      end

      it 'packagizes when mixed' do
        @rails.send(:packagize, [:active_record, 'activemodel']).should =~ ['activerecord', 'activemodel']
      end
    end
  end

  describe '#version' do
    it 'returns specified version when version' do
      @rails = Mactag::Indexer::Rails.new(:version => '3.0.0')
      @rails.send(:version).should == '3.0.0'
    end

    it 'returns same version as app when version option is not specified' do
      Rails.stub(:version) { '3.0.0' }

      @rails.send(:version).should == '3.0.0'
    end
  end
end
