module Mactag
  module Tag
    ##
    #
    # Tag plugins in Rails project.
    #
    # ==== Examples
    #
    #   Mactag do
    #     # Index single plugin.
    #     plugin 'whenever'
    #
    #     # Index multiple plugins.
    #     plugins 'thinking-sphinx', 'formtastic'
    #
    #     # Index all plugins.
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
          File.join(PLUGIN_PATH, name, 'lib', '**', '*.rb')
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
        Dir.glob(pattern).map do |file|
          basename = File.basename(file)

          Mactag::Tag::Plugin.new(basename)
        end
      end
    end
  end
end
