module Mactag
  module Tag
    ##
    #
    # Tag files in current project.
    #
    # ==== Examples
    #
    #   Mactag do
    #     # Index single file.
    #     index 'lib/super_duper.rb'
    #
    #     # Index all ruby files in lib, recursive.
    #     index 'lib/**/*.rb'
    #
    #     # Index all helper and model ruby files.
    #     index 'app/helpers/*.rb', 'app/models/*.rb'
    #
    #     # Same as above
    #     index 'app/{models,helpers}/*.rb'
    #   do
    #
    class App
      attr_reader :tag

      def initialize(tag)
        @tag = tag
      end
    end
  end
end
