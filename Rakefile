require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new

task :default => :test

desc "Open an irb session to work with bitarray"
task :console do
  sh "irb -rubygems -I lib -r bitarray"
end
