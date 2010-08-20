module Mactag
  class EventHandler
    def update(file)
      tags_file = Mactag::TagsFile.new(file)
      if tags_file.exists?
        tags_file.delete
        tags_file.create
      end
    end
    
    def delete(file)
      tags_file = Mactag::TagsFile.new(file)
      if tags_file.exists?
        tags_file.delete
      end
    end
    
    def create(file)
      Mactag::TagsFile.new(file).create
    end
  end
end
