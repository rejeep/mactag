module Mactag
  module Tag
    ##
    #
    # Index Rails.
    #
    # ==== Packages
    #
    # These are the packages that can be indexed. Naming does not
    # matter, so *activerecord* and *active_record* are the same.
    #
    # * actionmailer
    # * actionpack
    # * activemodel
    # * activerecord
    # * activeresource
    # * railties
    # * activesupport
    #
    #
    # ==== Examples
    #
    #   Mactag do
    #     # Index all packages, same version as application
    #     index :rails
    #
    #     # Index all packages, version 3.1.3
    #     index :rails, :version => '3.1.3'
    #
    #     # Index all packages except activerecord, same version as application
    #     index :rails, :except => :activerecord
    #
    #     # Index only activerecord and actionview, same version as application
    #     index :rails, :only => [:activerecord, :action_view]
    #
    #     # Index all packages except activerecord and actionview,
    #     # same version as application
    #     index :rails, :except => ['activerecord', :action_controller]
    #
    #     # Index all packages except actionmailer, version 3.1.3
    #     index :rails, :except => :actionmailer, :version => '3.1.3'
    #   do
    #
    class Rails

      PACKAGES = %w(actionmailer actionpack activemodel activerecord activeresource activesupport railties)

      attr_accessor :only, :except, :version

      def initialize(options)
        @only = packagize(options[:only])
        @except = packagize(options[:except])
        @version = options[:version]
      end

      def tag
        packages.inject([]) do |array, package|
          array << Gem.new(package, version).tag
          array
        end
      end

      def packages
        if only || except
          only || PACKAGES - except
        else
          PACKAGES
        end
      end


      private

      def packagize(pkgs)
        return nil if pkgs.blank?

        Array(pkgs).map do |pkg|
          "#{pkg}".gsub(/[^a-z]/, '')
        end
      end

      def version
        @version || ::Rails.version
      end
    end
  end
end
