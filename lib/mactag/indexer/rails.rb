module Mactag
  module Indexer
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

      def version
        @version || ::Mactag.rails_version
      end


      private

      def packagize(packages)
        return nil unless packages && packages.any?

        Array(packages).map do |package|
          "#{package}".gsub(/[^a-z]/, '')
        end
      end
    end
  end
end
