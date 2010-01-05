require 'rake'
require 'rake/testtask'
require 'cucumber/rake/task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "mactag"
    gemspec.summary = "Ctags for Rails"
    gemspec.description = "Mactag is DSL in ruby for creating a Ctags-file for Rails projects"
    gemspec.email = "johan.rejeep@gmail.com"
    gemspec.homepage = "http://github.com/rejeep/mactag"
    gemspec.authors = ["Johan Andersson"]
    gemspec.files = FileList[
                             "lib/**/*.rb",
                             "LICENCE",
                             "README.markdown",
                             "tasks/**/*.rake",
                             "generators/**/*.rb",
                             "VERSION"
                            ]
    gemspec.test_files = FileList[
                                  "features/**/*",
                                  "test/**/*_test.rb"
                                 ]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format progress"
end

task :default => [:test, :features]
