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

module Aef
  module Linebreak
    module CLI

      # Command-line sub-command to display version and license info.
      class VersionCommand

        # Main program
        def execute
          # Read licensing information from the top of this file
          license = File.read(__FILE__)[/=begin\n(.*)\n=end/m, 1]
      
          puts <<-TEXT
Linebreak::CLI #{Aef::Linebreak::CLI::VERSION}
using Linebreak #{Aef::Linebreak::VERSION}

Project: https://github.com/aef/linebreak-cli/
Documentation: http://rdoc.info/github/aef/linebreak-cli/

#{license}
          TEXT
      
          exit false
        end
      end

    end
  end
end
