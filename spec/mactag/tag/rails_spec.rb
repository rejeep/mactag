require 'spec_helper'

describe Mactag::Tag::Rails do
  it 'should have correct packages' do
    Mactag::Tag::Rails::PACKAGES.should =~ [:actionmailer, :actionpack, :activemodel, :activerecord, :activeresource, :railties, :activesupport]
  end

  describe '#tag' do
    before do
      @rails = Mactag::Tag::Rails.new({})
    end

    it 'return empty array if no packages' do
      @rails.stub!(:packages).and_return([])

      @rails.tag.should be_empty
    end

    it 'should return array with gem tags when packages' do
      @rails.stub!(:packages).and_return([:activemodel, :activerecord])

      o = Object.new
      def o.tag
        'tag'
      end

      Mactag::Tag::Gem.stub!(:new).and_return(o)

      @rails.tag.should =~ ['tag', 'tag']
    end
  end

  describe '#packages' do
    it 'should return all packages when no arguments' do
      @rails = Mactag::Tag::Rails.new({})

      @rails.send(:packages).should =~ Mactag::Tag::Rails::PACKAGES
    end

    it 'should return some packages when only specified' do
      @rails = Mactag::Tag::Rails.new(:only => [:active_support, :activerecord])

      @rails.send(:packages).should =~ [:activesupport, :activerecord]
    end

    it 'return some packages when except specified' do
      @rails = Mactag::Tag::Rails.new(:except => [:active_support, :activerecord])

      @rails.send(:packages).should =~ (Mactag::Tag::Rails::PACKAGES - [:activesupport, :activerecord])
    end
  end

  describe '#packagize' do
    before do
      @rails = Mactag::Tag::Rails.new({})
    end

    context 'single package' do
      before do
        @packagized = @rails.send(:packagize, 'active_record')
      end

      it 'should return package packagized' do
        @packagized.should =~ [:activerecord]
      end
    end

    context 'multiple packages' do
      before do
        @packagized = @rails.send(:packagize, ['_active_support_', :action_view])
      end

      it 'should return packages packagized' do
        @packagized.should =~ [:activesupport, :actionview]
      end
    end
  end

  describe '#version' do
    it 'should pick specified version when given' do
      @rails = Mactag::Tag::Rails.new({ :version => '3.0.0.rc' })

      @rails.send(:version).should == '3.0.0.rc'
    end

    it 'pick same rails version as application when not specified version' do
      Rails.stub!(:version).and_return('3.0.0.beta3')

      @rails = Mactag::Tag::Rails.new({})

      @rails.send(:version).should == '3.0.0.beta3'
    end
  end
end
