module Mactag
  class TagsFile
    def initialize(file)
      @input = file
      @output = output(file)
    end

    def create
      system "/usr/local/Cellar/ctags/5.8/bin/ctags -o #{@output} -e #{@input}"
    end

    def delete
      File.delete(@output)
    end
    
    def exist?
      File.exists?(@output)
    end

    private

    def output(file)
      basename = File.basename(file)
      dirname = File.dirname(file)

      filename = [dirname.gsub(/\//, '_'), basename].join('_')

      File.join(Rails.root, Mactag::Config.tags_dir, filename)
    end
  end
end
