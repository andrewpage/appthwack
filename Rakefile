require "bundler"
require 'rspec/core/rake_task'

Bundler.setup
RSpec::Core::RakeTask.new('spec')

gemspec = eval(File.read("appthwack.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["appthwack.gemspec"] do
  system "gem build appthwack.gemspec"
end

desc "deploy the gem and tag the version"
task :deploy do
  `gem build appthwack.gemspec`
  `git tag v#{Appthwack::VERSION}` if $?.exitstatus == 0
  `git push origin v#{Appthwack::VERSION}` if $?.exitstatus == 0
  `curl -F p1=@appthwack-#{Appthwack::VERSION}.gem https://gems.gemfury.com/P6HxhuAq3NRTM1wqCxJS/` if $?.exitstatus == 0
  `rm *.gem`
end