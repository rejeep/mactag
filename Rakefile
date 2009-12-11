require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :cucumber do
  system "cucumber features"
end
