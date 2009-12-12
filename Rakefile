require 'rake'
require 'rake/testtask'

task :default => :test
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :features do
  system "cucumber features"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "mactag"
    gemspec.summary = "Emacs TAGS for Rails"
    gemspec.description = "Mactag is DSL in ruby for creating an Emacs TAGS-file for Rails projects"
    gemspec.email = "johan.rejeep@gmail.com"
    gemspec.homepage = "http://github.com/rejeep/mactag"
    gemspec.authors = ["Johan Andersson"]
    gemspec.files = FileList[
                             "Rakefile",
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
