require 'spec_helper'

describe Mactag::Tag::Rails do
  subject do
    Mactag::Tag::Rails.new({})
  end

  it_should_behave_like 'tagger'

  before do
    @rails = Mactag::Tag::Rails.new({})
  end

  it 'has correct default packages' do
    Mactag::Tag::Rails::PACKAGES.should eq(['actionmailer', 'actionpack', 'activemodel', 'activerecord', 'activeresource', 'activesupport', 'railties'])
  end

  describe '#tag' do
    before do
      Mactag::Tag::Gem.stub(:new) { mock(:tag => 'tag') }
    end

    it 'returns empty array if no packages' do
      @rails.stub(:packages) { [] }

      @rails.tag.should eq([])
    end

    it 'returns array with gem tags when packages' do
      @rails.stub(:packages) { ['activemodel', 'activerecord'] }

      @rails.tag.should eq(['tag', 'tag'])
    end
  end

  describe '#packages' do
    it 'returns all packages unless only and except' do
      @rails.packages.should eq(Mactag::Tag::Rails::PACKAGES)
    end

    it 'returns some packages when only specified' do
      @rails = Mactag::Tag::Rails.new(:only => [:active_support, :activerecord])

      @rails.packages.should eq(['activesupport', 'activerecord'])
    end

    it 'returns some packages when except specified' do
      @rails = Mactag::Tag::Rails.new(:except => [:active_support, :activerecord])

      @rails.packages.should eq(['actionmailer', 'actionpack', 'activemodel', 'activeresource', 'railties'])
    end
  end

  describe '#packagize' do
    it 'returns empty array when no packages' do
      @rails.send(:packagize, []).should be_nil
    end

    context 'single package' do
      it 'packagizes when symbol' do
        @rails.send(:packagize, [:activerecord]).should eq(['activerecord'])
      end

      it 'packagizes when string' do
        @rails.send(:packagize, ['activerecord']).should eq(['activerecord'])
      end

      it 'packagizes when underscore' do
        @rails.send(:packagize, [:active_record]).should eq(['activerecord'])
      end
    end

    context 'multiples packages' do
      it 'packagizes when symbols' do
        @rails.send(:packagize, [:activerecord, :activemodel]).should eq(['activerecord', 'activemodel'])
      end

      it 'packagizes when string' do
        @rails.send(:packagize, ['activerecord', 'activemodel']).should eq(['activerecord', 'activemodel'])
      end

      it 'packagizes when underscore' do
        @rails.send(:packagize, [:active_record, :active_model]).should eq(['activerecord', 'activemodel'])
      end

      it 'packagizes when mixed' do
        @rails.send(:packagize, [:active_record, 'activemodel']).should eq(['activerecord', 'activemodel'])
      end
    end
  end

  describe '#version' do
    it 'returns specified version when version option' do
      @rails = Mactag::Tag::Rails.new(:version => '3.0.0')

      @rails.send(:version).should eq('3.0.0')
    end

    it 'returns same version as rails application when version option is not specified' do
      Rails.stub(:version) { '3.0.0' }

      @rails.send(:version).should eq('3.0.0')
    end
  end
end
