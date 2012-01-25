module Mactag
  module Config
    class << self
      def configure(&block)
        yield self
      end

      def add_config(name, &block)
        unless respond_to?(name)
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def self.#{name}
              @#{name}
            end
          RUBY
        end

        unless respond_to?("#{name}=")
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def self.#{name}=(value)
              @#{name} = value
            end
          RUBY
        end
      end

      def gem_home
        if rvm
          File.join(ENV['GEM_HOME'], 'gems')
        else
          @gem_home
        end
      end

      def rvm=(rvm)
        if rvm == true || rvm == false
          @rvm = rvm
        else
          raise Mactag::MactagError.new("RVM must be either true or false")
        end
      end

      def binary=(binary)
        if binary.include?('{INPUT}') && binary.include?('{OUTPUT}')
          @binary = binary
        else
          raise Mactag::MactagError.new("Binary command must include '{INPUT}' and '{OUTPUT}'")
        end
      end

      def reset_config
        configure do |config|
          config.binary = 'ctags -o {OUTPUT} -e {INPUT}'
          config.tags_file = 'TAGS'
          config.rvm = true
          config.gem_home = '/Library/Ruby/Gems/1.8/gems'
        end
      end
    end

    add_config :binary
    add_config :tags_file
    add_config :rvm
    add_config :gem_home

    reset_config
  end
end
