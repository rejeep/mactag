require 'test_helper'

class RailsTest < ActiveSupport::TestCase

  should "have correct vendor path" do
    assert_equal "vendor/rails", Mactag::Tag::Rails::VENDOR
  end

  should "have correct packages" do
    packages = Mactag::Tag::Rails::PACKAGES
    keys = packages.keys

    assert_contains keys, :activesupport
    assert_contains keys, :activeresource
    assert_contains keys, :activerecord
    assert_contains keys, :actionmailer
    assert_contains keys, :actioncontroller
    assert_contains keys, :actionview
  end

  should "have the correct paths" do
    packages = Mactag::Tag::Rails::PACKAGES

    assert_equal ["activesupport", "active_support"]  , packages[:activesupport]
    assert_equal ["activeresource", "active_resource"], packages[:activeresource]
    assert_equal ["activerecord", "active_record"]    , packages[:activerecord]
    assert_equal ["actionmailer", "action_mailer"]    , packages[:actionmailer]
    assert_equal ["actionpack", "action_controller"]  , packages[:actioncontroller]
    assert_equal ["actionpack", "action_view"]        , packages[:actionview]
  end

  context "packages" do
    context "without arguments" do
      setup do
        @rails = Mactag::Tag::Rails.new({})
      end

      should "return all packages" do
        assert_same_elements Mactag::Tag::Rails::PACKAGES.keys, @rails.packages
      end
    end

    context "with some packages only" do
      setup do
        @rails = Mactag::Tag::Rails.new(:only => [:active_support, :activerecord])
      end

      should "return only those packages" do
        assert_same_elements [:activesupport, :activerecord], @rails.packages
      end
    end

    context "except some packages" do
      setup do
        @rails = Mactag::Tag::Rails.new(:except => [:active_support, :activerecord])
      end

      should "return all except those packages" do
        assert_same_elements Mactag::Tag::Rails::PACKAGES.keys - [:activesupport, :activerecord], @rails.packages
      end
    end
  end

  context "rails in vendor" do
    setup do
      File.stubs(:exist?).returns(true)
    end

    should "be in vendor since file exist" do
      assert Mactag::Tag::Rails.vendor?
    end
  end

  context "rails home" do
    context "when rails is in vendor" do
      setup do
        Mactag::Tag::Rails.stubs(:vendor?).returns(true)

        @rails = Mactag::Tag::Rails.new({})
      end

      should "return vendor" do
        assert_equal Mactag::Tag::Rails::VENDOR, @rails.rails_home
      end
    end

    context "when rails is installed as a gem" do
      setup do
        Mactag::Tag::Rails.stubs(:vendor?).returns(false)

        @rails = Mactag::Tag::Rails.new({})
      end

      should "return gem home" do
        assert_equal Mactag::Config.gem_home, @rails.rails_home
      end
    end
  end
  
  context "packagize" do
    setup do
      @rails = Mactag::Tag::Rails.new({})
    end
    
    context "one package" do
      setup do
        @packagized = @rails.send(:packagize!, "active_record")
      end
      
      should "be packagized" do
        assert_equal [:activerecord], @packagized
      end
    end
    
    context "several packages" do
      setup do
        @packagized = @rails.send(:packagize!, ["_active_support_", "action_view"])
      end
      
      should "be packagized" do
        assert_equal [:activesupport, :actionview], @packagized
      end
    end
  end
  
  context "package paths" do
    context "when rails is in vendor" do
      setup do
        Mactag::Tag::Rails.stubs(:vendor?).returns(true)
        
        @rails = Mactag::Tag::Rails.new({})
      end
      
      should "return the correct path" do
        assert_equal "activerecord/lib/active_record", @rails.package_path(:activerecord)
      end
    end
    
    context "when rails is installed as a gem" do
      setup do
        Mactag::Tag::Rails.stubs(:vendor?).returns(false)
      end
      
      context "and there is a specific version" do
        setup do
          @rails = Mactag::Tag::Rails.new(:version => "3.0.0")
        end
        
        should "return the correct path" do
          assert_equal "activerecord-3.0.0/lib/active_record", @rails.package_path(:activerecord)
        end
      end
      
      context "and there is no version specified" do
        setup do
          @rails = Mactag::Tag::Rails.new({})
        end
        
        context "and there is only one version of rails" do
          setup do
            Dir.stubs(:glob).returns("activerecord-2.3.5")
          end
          
          should "return the correct path" do
            assert_equal "activerecord-2.3.5/lib/active_record", @rails.package_path(:activerecord)
          end
        end
        
        context "and there are two versions of rails" do
          setup do
            Dir.stubs(:glob).returns(["activerecord-2.3.5", "activerecord-2.3.4"])
          end
          
          should "return the correct path" do
            assert_equal "activerecord-2.3.5/lib/active_record", @rails.package_path(:activerecord)
          end
        end
      end
    end
  end
  
end
