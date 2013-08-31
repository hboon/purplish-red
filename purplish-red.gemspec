# -*- encoding: utf-8 -*-
require File.expand_path('../lib/purplish-red/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'purplish-red'
  gem.version       = PurplishRed::VERSION
  gem.licenses      = ['BSD']

  gem.authors  = ['Hwee-Boon Yar']

  gem.description = 'A set of wrappers and helpers for working with iOS using RubyMotion'
  gem.summary = 'A set of wrappers and helpers for working with iOS using RubyMotion'
  gem.homepage = 'https://github.com/hboon/purplish-red'
  gem.email = 'hboon@motionobj.com'

  gem.files       = `git ls-files`.split($\)
  gem.require_paths = ['lib']
  #gem.test_files  = gem.files.grep(%r{^spec/})
end
