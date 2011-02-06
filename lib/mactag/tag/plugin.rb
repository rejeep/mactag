module Mactag
  module Tag
    ##
    #
    # Tag plugins in Rails project.
    #
    # ==== Examples
    #   Mactag do
    #     # Tag single plugin
    #     plugin 'whenever'
    #
    #     # Tag multiple plugins
    #     plugins 'thinking-sphinx', 'formtastic'
    #
    #     # Tag all plugins
    #     plugins
    #   do
    #
    class Plugin
      PLUGIN_PATH = %w(vendor plugins)

      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def tag
        if exists?
          return File.join(PLUGIN_PATH, name, 'lib', '**', '*.rb')
        else
          raise PluginNotFoundError.new(self)
        end
      end

      def exists?
        File.directory?(path)
      end

      def path
        File.join(PLUGIN_PATH, name)
      end

      def self.all
        pattern = File.join(PLUGIN_PATH, '*')
        Dir.glob(pattern).map do |f|
          File.basename(f)
        end
      end
    end
  end
end
