# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@godobject.net>, 2009-2013

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

require 'bundler'

Bundler.setup

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
end

require 'pry'
require 'rspec'
require 'tempfile'
require 'rbconfig'
require 'childprocess'
require 'aef/linebreak/cli'

module LinebreakSpecHelper
  INTERPRETER = Pathname(RbConfig::CONFIG['bindir']) + RbConfig::CONFIG['ruby_install_name']
  FIXTURES_DIR = Pathname('spec/fixtures')

  def executable_path
    "#{INTERPRETER} -Ilib bin/linebreak"
  end

  def command(arguments, options = {})
    argument_array = arguments.split(' ')

    process = ChildProcess.build(INTERPRETER.to_s, '-Ilib', 'bin/linebreak', *argument_array)
    process.duplex = options[:duplex]

    stdout, process.io.stdout = IO.pipe
    stderr, process.io.stderr = IO.pipe
    
    process.start

    [process, stdout, stderr]
  end

  def fixture_path(name)
    FIXTURES_DIR + name
  end

  def windows?
    RbConfig::CONFIG['target_os'].downcase.include?('win')
  end

  def version_message
    <<-EOS
Linebreak::CLI #{Aef::Linebreak::CLI::VERSION}
using Linebreak #{Aef::Linebreak::VERSION}

Project: https://github.com/aef/linebreak-cli/
Documentation: http://rdoc.info/github/aef/linebreak-cli/

Copyright Alexander E. Fischer <aef@godobject.net>, 2009-2013

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
    EOS
  end

  def env(environment = {})
    raise ArgumentError, 'A block needs to be given' unless block_given?

    backup = {}

    environment.each do |key, value|
      key, value = key.to_s, value.to_s

      backup[key] = ENV[key]
      ENV[key] = value
    end

    result = yield

    backup.each do |key, value|
      ENV[key] = value
    end

    result
  end
end

RSpec.configure do |config|
  config.include LinebreakSpecHelper
end
