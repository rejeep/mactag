task :environment

desc "Creates a Ctags file"
task :mactag => :environment do
  require File.join(Rails.root, "config", "mactag")

  Mactag::Builder.create
end
