class TagsFile
  def initialize(app)
    @app = app
    @file = File.join(@app.root, "TAGS")

    create
  end

  def include?(definition)
    File.open(@file) do |file|
      return file.read =~ /#{definition}/
    end
  end


  private

  def create
    cmd = "cd #{@app.root}"
    cmd << " && rake mactag"
    cmd << " --trace" if ENV['DEBUG'] == 'true'
    system cmd
  end
end
