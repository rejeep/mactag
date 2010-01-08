class RailsApp

  attr_reader :name

  def initialize(name = "rails_app")
    @name = name

    create
  end

  def destroy
    FileUtils.rm_rf(rails_root)
  end

  def puts(file, contents = nil, &block)
    file = File.join(rails_root, file)
    text = contents || (block_given? ? instance_eval(&block) : "")
    File.open(file, "a") { |f| f.write(text) }
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

  def install_rails_vendor
    from = File.join("features", "rails")
    to = File.join(rails_root, "vendor", "rails-temp")

    FileUtils.cp_r(from, to)
  end

  def install_rails_gem(version = "3.0.0")
    from = File.join("features", "rails", "*")
    to = File.join(rails_root, "vendor", "rails-temp")

    FileUtils.mkdir_p(to)

    Dir.glob(from).each do |file|
      FileUtils.cp_r(file, to)
    end

    Dir.glob(File.join(to, "*[a-z]")).each do |file|
      FileUtils.mv(file, "#{file}-#{version}")
    end
  end

  def gsub(file, from, to)
    text = File.read(file)
    File.open(file, 'w+') do |f|
      f << text.gsub(from, to)
    end
  end

  def rails_root
    @rails_root ||= File.join(File.dirname(__FILE__), "..", "..", @name)
  end


  private

  def create
    system "rails #{rails_root} -q"
  end
end
