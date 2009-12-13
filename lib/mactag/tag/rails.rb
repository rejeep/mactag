require 'mactag/tag/versioned'

module Mactag
  module Tag

    # Tag for the Rails source.
    #
    # ==== Packages
    # Naming does not matter. So *activerecord* and *active_record* are the same.
    #
    # * activesupport
    # * activeresource
    # * activerecord
    # * actionmailer
    # * actioncontroller
    # * actionview
    #
    # ==== Examples
    #   Mactag::Table.generate do
    #     # Tag all rails packages, latest version
    #     rails
    #
    #     # Tag all rails packages, version 2.3.5
    #     rails :version => "2.3.5"
    #
    #     # Tag only activerecord, latest version
    #     rails :only => :active_record
    #
    #     # Tag all packages except activerecord, latest version
    #     rails :except => :activerecord
    #
    #     # Tag only activerecord and actionview, latest version
    #     rails :only => [:activerecord, :action_view]
    #
    #     # Tag all packages except activerecord and actionview, latest version
    #     rails :except => ["activerecord", :action_controller]
    #
    #     # Tag all packages except actionmailer, version 2.3.4
    #     rails :except => :actionmailer, :version => "2.3.4"
    #   do
    class Rails
      
      include Versioned

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


      private

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
        paths = PACKAGES[package].dup
        paths.insert(1, "lib")

        unless Mactag::Tag::Rails.vendor?
          top = paths.first
          if version = @options[:version]
            top = "#{top}-#{version}"
          else
            top = File.basename(latest(top))
          end
          paths[0] = top
        end

        File.join(paths)
      end

      def self.vendor?
        File.exist?(VENDOR)
      end

      def rails_home
        @rails_home ||= Mactag::Tag::Rails.vendor? ? VENDOR : Mactag::Config.gem_home
      end

      def packagize!(pkgs)
        return nil if pkgs.blank?

        Array(pkgs).collect do |pkg|
          "#{pkg}".gsub(/[^a-z]/, '').to_sym
        end
      end

    end
  end
end
