class RailsApp

  attr_reader :name

  def initialize(name = "rails_app")
    @name = name

    create
  end

  def destroy
    FileUtils.rm_rf(rails_root)
  end
  
  def puts(file, &block)
    file = File.join(rails_root, file)
    contents = block_given? ? instance_eval(&block) : ""
    File.open(file, "a") { |f| f.write(contents) }
  end
  
  def install_plugin(plugin)
    system "cd #{rails_root} && ./script/generate plugin #{plugin} &> /dev/null"
  end
  
  def install_gem(gem, version)
    install_plugin(gem)

    plugins = File.join(rails_root, "vendor", "plugins")
    gems = File.join(rails_root, "vendor", "gems")
    
    FileUtils.mkdir_p(gems)
    FileUtils.mv(File.join(plugins, gem), File.join(gems, "#{gem}-#{version}"))
  end
  
  def rails_root
    @rails_root ||= File.join(File.dirname(__FILE__), "..", "..", @name)
  end
  

  private

  def create
    system "rails #{rails_root} -q"
  end
end
