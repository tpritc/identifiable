# frozen_string_literal: true

require_relative 'lib/identifiable/version'

Gem::Specification.new do |spec|
  spec.version       = Identifiable::VERSION
  spec.name          = 'identifiable'
  spec.authors       = ['Tom Pritchard']
  spec.email         = ['hi@tpritc.com']

  spec.summary       = 'A quick and easy way to add random, customizable, public-facing IDs to your models.'
  spec.homepage      = 'https://github.com/tpritc/identifiable'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '> 5.2'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.3'
  spec.add_development_dependency 'sqlite3'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
