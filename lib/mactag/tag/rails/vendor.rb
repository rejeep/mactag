module Mactag
  module Tag
    module Rails
      class Vendor

        include Mactag::Tag::Rails

        def files
          result = []
          
          packages.each do |package|
            path = []
            path << rails_home
            path << package_lib(package)
            path << "**"
            path << "*.rb"
            path.flatten!

            result << Dir.glob(File.join(path))
          end

          result.flatten
        end

      end
    end
  end
end
