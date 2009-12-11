module Mactag
  module Tag
    class Rails

      VENDOR = File.join("vendor", "rails")

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

      def package_path(package)
        paths = PACKAGES[package]
        paths.insert(1, "lib")

        unless Mactag::Tag::Rails.vendor?
          top = paths.first
          if version = @options[:version]
            top = "#{top}-#{version}"
          else
            versions = Dir.glob(File.join(Mactag::Config.gem_home, "#{top}-*"))

            if versions.size == 1
              top = versions.first
            else
              top = versions.sort.last
            end

            top = File.basename(top)
          end
          paths[0] = top
        end

        File.join(paths)
      end

      def files
        result = []

        packages.each do |package|
          path = []
          path << rails_home
          path << package_path(package)
          path << "**"
          path << "*.rb"
          path.flatten!

          result << Dir.glob(File.join(path))
        end

        result.flatten
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

        Array(pkgs).collect do |pkg|
          "#{pkg}".gsub(/[^a-z]/, '').to_sym
        end
      end

    end
  end
end
