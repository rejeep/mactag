task :environment

desc "Creates a Ctags file"
task :mactag => :environment do
  require File.join(Rails.root, "config", "mactag")

  system "cd #{Rails.root} && #{Mactag::Config.binary} #{Mactag::Table.tags}"
end
