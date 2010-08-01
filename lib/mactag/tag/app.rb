module Mactag
  module Tag
    ##
    #
    # Tags files in current Rails application.
    #
    # ==== Examples
    #   Mactag::Table.generate do
    #     # Tag single file
    #     app 'lib/super_duper.rb'
    #
    #     # Tag all files in lib, recursive
    #     app 'lib/**/*.rb'
    #
    #     # Tag all helpers and models
    #     app 'app/helpers/*.rb', 'app/models/*.rb'
    #
    #     # Same as above
    #     app 'app/{models,helpers}/*.rb'
    #   do
    #
    class App
      def initialize(files)
        @files = files
      end
      
      def files
        Array(@files)
      end
    end
  end
end
