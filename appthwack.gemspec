$:.unshift File.expand_path("../lib", __FILE__)
require 'appthwack/version'

Gem::Specification.new do |gem|
  gem.name          = "appthwack"
  gem.version       = Appthwack::VERSION
  gem.authors       = ["cisimple"]
  gem.email         = %w(team@cisimple.com)
  gem.description   = %q{API client for Appthwack}
  gem.summary       = %q{Run tests using Appthwack's mobile devices.}
  gem.homepage      = "https://github.com/cisimple-team/appthwack"

  gem.files         = %x{ git ls-files }.split("\n").select{|d| d =~ %r{^(License|README|bin/|lib/)}}
  gem.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  gem.rdoc_options  = %w(--charset=UTF-8)

  gem.add_dependency 'rest-client', '~>1.6'
  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_development_dependency 'fakeweb', '~> 1.30'
  gem.add_development_dependency 'timecop', '~> 0.60'
end
