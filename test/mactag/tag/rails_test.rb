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

  context "packages" do
    context "without arguments" do
      setup do
        @rails = Mactag::Tag::Rails.new({})
      end

      should "return all packages" do
        assert_same_elements Mactag::Tag::Rails::PACKAGES, @rails.send(:packages)
      end
    end

    context "with some packages only" do
      setup do
        @rails = Mactag::Tag::Rails.new(:only => [:active_support, :activerecord])
      end

      should "return only those packages" do
        assert_same_elements [:activesupport, :activerecord], @rails.send(:packages)
      end
    end

    context "except some packages" do
      setup do
        @rails = Mactag::Tag::Rails.new(:except => [:active_support, :activerecord])
      end

      should "return all except those packages" do
        assert_same_elements Mactag::Tag::Rails::PACKAGES - [:activesupport, :activerecord], @rails.send(:packages)
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
        @packagized = @rails.send(:packagize!, ["_active_support_", :action_view])
      end

      should "be packagized" do
        assert_equal [:activesupport, :actionview], @packagized
      end
    end
  end
end
