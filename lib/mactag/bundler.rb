module Mactag
  ##
  #
  # For fetching information from Bundler regarding what gems are
  # used.
  #
  class Bundler
    class << self
      def gems
        dependencies.map do |dependency|
          [dependency, specs[dependency]]
        end
      end


      private

      def specs
        @specs ||= runtime.specs.inject({}) do |hash, spec|
          hash[spec.name] = spec.version.to_s
          hash
        end
      end

      def dependencies
        default = runtime.dependencies.select { |dependency|
          dependency.groups.include?(:default)
        }.map(&:name)
        default.delete('rails')
        default
      end

      def runtime
        @runtime ||= ::Bundler.load
      end
    end
  end
end
