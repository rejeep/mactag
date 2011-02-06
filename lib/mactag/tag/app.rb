module Mactag
  module Tag
    ##
    #
    # Tag files in Rails project.
    #
    # ==== Examples
    #   Mactag do
    #     # Tag single file
    #     app 'lib/super_duper.rb'
    #
    #     # Tag all ruby files in lib, recursive
    #     app 'lib/**/*.rb'
    #
    #     # Tag all helper and model ruby files
    #     app 'app/helpers/*.rb', 'app/models/*.rb'
    #
    #     # Same as above
    #     app 'app/{models,helpers}/*.rb'
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
