require 'mactag/tag/rails/vendor'
require 'mactag/tag/rails/gem'

module Mactag
  module Tag
    module Rails

      VENDOR = File.join(::Rails.root, "vendor", "rails-temp")

      PACKAGES = {
        :activesupport    => ["activesupport", "active_support"],
        :activeresource   => ["activeresource", "active_resource"],
        :activerecord     => ["activerecord", "active_record"],
        :actionmailer     => ["actionmailer", "action_mailer"],
        :actioncontroller => ["actionpack", "action_controller"],
        :actionview       => ["actionpack", "action_view"]
      }

      def initialize(options)
        @options = options

        @only = packagize!(options[:only])
        @except = packagize!(options[:except])
      end

      def packages
        result = []

        unless @only || @except
          result = PACKAGES.keys
        else
          if @only
            result = @only
          elsif @except
            result = PACKAGES.keys - @except
          end
        end

        result
      end

      def package_lib(package)
        pkg = PACKAGES[package]

        File.join(pkg.first, "lib", pkg.last)
      end

      def self.vendor?
        File.exist?(VENDOR)
      end

      def rails_home
        @rails_home ||= Mactag::Tag::Rails.vendor? ? VENDOR : Mactag::Config.gem_home
      end


      private

      def packagize!(pkgs)
        return nil if pkgs.blank?

        pkgs.collect do |pkg|
          "#{pkg}".gsub(/[^a-z]/, '').to_sym
        end
      end

    end
  end
end
