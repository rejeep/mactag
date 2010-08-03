require 'test_helper'

class RailsTest < ActiveSupport::TestCase
  should "have correct packages" do
    packages = Mactag::Tag::Rails::PACKAGES

    [
     :actionmailer,
     :actionpack,
     :activemodel,
     :activerecord,
     :activeresource,
     :railties,
     :activesupport
    ].each do |package|
      assert_contains packages, package
    end
  end

  context '#tag' do
    should 'return empty array if no packages' do
      @rails = Mactag::Tag::Rails.new({})
      @rails.stubs(:packages).returns([])

      assert_equal [], @rails.tag
    end

    should 'return array with gem tags if packages' do
      @rails = Mactag::Tag::Rails.new({})
      @rails.stubs(:packages).returns([:activemodel, :activerecord])

      o = Object.new
      def o.tag
        'tag'
      end
      
      Mactag::Tag::Gem.stubs(:new).returns(o)
      
      assert_equal ['tag', 'tag'], @rails.tag
    end
  end

  context '#packages' do
    should 'return all packages if no arguments' do
      @rails = Mactag::Tag::Rails.new({})

      assert_same_elements Mactag::Tag::Rails::PACKAGES, @rails.send(:packages)
    end

    should 'return some packages if only specified' do
      @rails = Mactag::Tag::Rails.new(:only => [:active_support, :activerecord])

      assert_same_elements [:activesupport, :activerecord], @rails.send(:packages)
    end

    should 'return some packages if except specified' do

      @rails = Mactag::Tag::Rails.new(:except => [:active_support, :activerecord])

      assert_same_elements Mactag::Tag::Rails::PACKAGES - [:activesupport, :activerecord], @rails.send(:packages)
    end
  end

  context '#packagize' do
    setup do
      @rails = Mactag::Tag::Rails.new({})
    end

    context 'single package' do
      setup do
        @packagized = @rails.send(:packagize!, 'active_record')
      end

      should 'return a packagized package' do
        assert_equal [:activerecord], @packagized
      end
    end

    context 'multiple packages' do
      setup do
        @packagized = @rails.send(:packagize!, ['_active_support_', :action_view])
      end

      should 'return packagized packages' do
        assert_equal [:activesupport, :actionview], @packagized
      end
    end
  end
  
  context '#version' do
    should 'pick specified version if given' do
      @rails = Mactag::Tag::Rails.new({ :version => '3.0.0.rc' })
      
      assert_equal '3.0.0.rc', @rails.send(:version)
    end
    
    should 'pick same rails version as application if not specified version' do
      Rails.stubs(:version).returns('3.0.0.beta3')
      
      @rails = Mactag::Tag::Rails.new({})
      
      assert_equal '3.0.0.beta3', @rails.send(:version)
    end
  end
end
