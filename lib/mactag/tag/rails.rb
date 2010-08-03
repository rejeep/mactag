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
    #     # Tag all rails packages, latest version
    #     rails
    #
    #     # Tag all rails packages, version 2.3.5
    #     rails :version => '2.3.5'
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
    #     rails :except => ['activerecord', :action_controller]
    #
    #     # Tag all packages except actionmailer, version 2.3.4
    #     rails :except => :actionmailer, :version => '2.3.4'
    #   do
    #
    class Rails
      PACKAGES = [
                  :actionmailer,
                  :actionpack,
                  :activemodel,
                  :activerecord,
                  :activeresource,
                  :railties,
                  :activesupport
                 ]

      def initialize(options)
        @options = options

        @only = packagize!(options[:only])
        @except = packagize!(options[:except])
      end

      def tag
        result = []
        packages.each do |package|
          if PACKAGES.include?(package)
            result << Gem.new(package.to_s, version).tag
          end
        end
        result
      end


      private

      ##
      #
      # Returns a list of all packages that should be included.
      #
      def packages
        result = []
        unless @only || @except
          result = PACKAGES
        else
          if @only
            result = @only
          elsif @except
            result = PACKAGES - @except
          end
        end
        result
      end

      ##
      #
      # Packagizes all +pkgs+.
      #
      def packagize!(pkgs)
        return nil if pkgs.blank?

        Array(pkgs).collect do |pkg|
          "#{pkg}".gsub(/[^a-z]/, '').to_sym
        end
      end

      ##
      #
      # Returns what Rails version to use.
      #
      def version
        @options[:version] || ::Rails.version
      end
    end
  end
end
