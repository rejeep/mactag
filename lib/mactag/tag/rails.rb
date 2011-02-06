module Mactag
  module Tag
    ##
    #
    # Tags Rails gem.
    #
    # ==== Packages
    # Naming does not matter, so *activerecord* and *active_record* are the same.
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
    #   Mactag do
    #     # Tag all rails packages, same rails version as application
    #     rails
    #
    #     # Tag all rails packages, version 2.3.5
    #     rails :version => '2.3.5'
    #
    #     # Tag only activerecord, same rails version as application
    #     rails :only => :active_record
    #
    #     # Tag all packages except activerecord, same rails version as application
    #     rails :except => :activerecord
    #
    #     # Tag only activerecord and actionview, same rails version as application
    #     rails :only => [:activerecord, :action_view]
    #
    #     # Tag all packages except activerecord and actionview, same rails version as application
    #     rails :except => ['activerecord', :action_controller]
    #
    #     # Tag all packages except actionmailer, version 2.3.4
    #     rails :except => :actionmailer, :version => '2.3.4'
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
