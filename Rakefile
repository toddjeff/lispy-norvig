# frozen_string_literal: true

require "rake/testtask"
require "rake/clean"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
  t.warning = true
end

task :autotest do
  sh "fswatch -o lib test | xargs -n1 -I{} bundle exec rake test"
end
