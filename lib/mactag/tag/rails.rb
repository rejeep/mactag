module Mactag
  module Tag
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
