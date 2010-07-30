class RailsApp
  NAME = "rails_app"

  def initialize
    create
  end

  def root
    @root ||= File.join(File.dirname(__FILE__), "..", "..", NAME)
  end

  def destroy
    FileUtils.rm_rf(root)
  end
  

  private

  def create
    cmd = "rails new #{NAME}"
    cmd << " -q" unless ENV['DEBUG'] == 'true'
    system cmd
  end
end
