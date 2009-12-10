class TagsFile
  def initialize(app)
    @app = app
    @tags_file = File.join(@app.rails_root, "TAGS")

    create
  end

  def contain?(tag)
    File.open(@tags_file) do |file|
      return file.read =~ /#{tag}/
    end
  end


  private

  def create
    system "cd #{@app.rails_root} && rake mactag --trace"
  end
end
