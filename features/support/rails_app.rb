class RailsApp

  attr_reader :name

  def initialize(name = "rails_app")
    @name = name

    create
  end

  def destroy
    FileUtils.rm_rf(rails_root)
  end

  def rails_root
    @rails_root ||= File.join(File.dirname(__FILE__), "..", "..", @name)
  end

  def puts(file, &block)
    file = File.join(rails_root, file)
    contents = block_given? ? instance_eval(&block) : ""
    File.open(file, "a") { |f| f.write(contents) }
  end
  

  private

  def create
    system "rails #{rails_root} -q"
  end
end
