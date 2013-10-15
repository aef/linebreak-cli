# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2012

This file is part of Linebreak::CLI.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
=end

require File.expand_path('../lib/aef/linebreak/cli/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name    = "linebreak-cli"
  gem.version = Aef::Linebreak::CLI::VERSION.dup
  gem.authors = ["Alexander E. Fischer"]
  gem.email   = ["aef@raxys.net"]
  gem.description = <<-DESCRIPTION
Linebreak::CLI is a Ruby command-line tool for conversion of text
between linebreak encoding formats of unix, windows or mac.

Before Linebreak 2.0.0 this tool was part of the linebreak gem.
Earlier versions of Linebreak were called BreakVerter.
  DESCRIPTION
  gem.summary  = "Command-line linebreak system conversion tool"
  gem.homepage = "https://aef.name/"
  gem.license  = "ISC"
  gem.has_rdoc = "yard"
  gem.extra_rdoc_files  = ["HISTORY.md", "LICENSE.md"]
  gem.rubyforge_project = nil

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency('linebreak', '~> 2.0.1')
  gem.add_dependency('user-choices', '~> 1.1.6.1')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('bundler')
  gem.add_development_dependency('rspec', '~> 2.11.0')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('childprocess', '~> 0.3.5')

  gem.cert_chain = "#{ENV['GEM_CERT_CHAIN']}".split(':')
  gem.signing_key = ENV['GEM_SIGNING_KEY']
end
