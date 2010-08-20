module Mactag
  class Server
    class << self
      def start
        create_tags_dir
        clear_tags
        init_tags
        init_monitor
      end


      private

      def create_tags_dir
        tags_dir = File.join(Rails.root, Mactag::Config.tags_dir)
        unless File.directory?(tags_dir)
          Dir.mkdir(tags_dir)
        end
      end

      def clear_tags
        tags_files = File.join(Rails.root, Mactag::Config.tags_dir, '*')
        Dir.glob(tags_files).each do |file|
          File.delete(file)
        end
      end

      def init_tags
        Mactag::Builder.builder.files.each do |file|
          Mactag::TagsFile.new(file).create
        end
      end

      def init_monitor
        event_handler = Mactag::EventHandler.new
        FSSM.monitor do
          Mactag::Builder.builder.directories.each do |directory|
            path(directory) do
              update { |base, relative| event_handler.update(File.join(base, relative)) }
              delete { |base, relative| event_handler.delete(File.join(base, relative)) }
              create { |base, relative| event_handler.create(File.join(base, relative)) }
            end
          end
        end
      end
    end
  end
end
