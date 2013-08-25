# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extconf_task/version'

Gem::Specification.new do |spec|
  spec.name          = "extconf-task"
  spec.version       = ExtconfTaskVersion::VERSION
  spec.authors       = ["Takayuki YAMAGUCHI"]
  spec.email         = ["d@ytak.info"]
  spec.description   = "Tiny rake tasks to manage extconf.rb"
  spec.summary       = "Tiny rake tasks to create Makefile, to compile, and to remove generated files"
  spec.homepage      = "https://github.com/ytaka/extconf-task"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
