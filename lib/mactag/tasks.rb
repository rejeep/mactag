Rake::Task[:environment].invoke

require File.join(Rails.root, "config", "mactag")

desc "Creates an Ctags file"
task :mactag do
  system "cd #{Rails.root} && #{Mactag::Config.binary} #{Mactag::Table.tags}"
end
