require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new      # defaults are fine for now
task :default => :test

task :bench do
  ruby "-Ilib benchmark/babm.rb"
end
task :benchmark => :bench
