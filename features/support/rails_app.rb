class RailsApp
  NAME = 'rails_app'

  def initialize
    create
  end

  def root
    @root ||= File.join(File.dirname(__FILE__), '..', '..', NAME)
  end

  def destroy
    FileUtils.rm_rf(root)
  end

  def inject(file, contents)
    to = File.join(root, file)
    File.open(to, 'a') { |f| f.write("#{contents}\n") }
  end

  def install_plugin(plugin)
    cmd = "cd #{root}"
    cmd << " && rails generate plugin #{plugin}"
    cmd << ' -q' unless ENV['DEBUG'] == 'true'
    system cmd
  end

  def install_gem(gem, version)
    install_plugin(gem)

    plugins = File.join(root, 'vendor', 'plugins')
    gems = File.join(root, 'vendor', 'gems')

    FileUtils.mkdir_p(gems)
    FileUtils.mv(File.join(plugins, gem), File.join(gems, "#{gem}-#{version}"))
  end
  

  private

  def create
    cmd = "rails new #{NAME}"
    cmd << ' -q' unless ENV['DEBUG'] == 'true'
    system cmd
  end
end
