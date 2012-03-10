Linebreak::CLI
==============

[![Build Status](https://secure.travis-ci.org/aef/linebreak-cli.png)](
https://secure.travis-ci.org/aef/linebreak-cli)

* [Documentation][docs]
* [Project][project]

   [docs]:    http://rdoc.info/projects/aef/linebreak-cli/
   [project]: https://github.com/aef/linebreak-cli/

Description
-----------

Linebreak::CLI is a Ruby command-line tool for conversion of text
between linebreak encoding formats of unix, windows or mac.

Before Linebreak 2.0.0 this tool was part of the linebreak gem.
Earlier versions of Linebreak were called BreakVerter.

Features / Problems
-------------------

This project tries to conform to:

* [Semantic Versioning (2.0.0-rc.1)][semver]
* [Ruby Packaging Standard (0.5-draft)][rps]
* [Ruby Style Guide][style]
* [Gem Packaging: Best Practices][gem]

   [semver]: http://semver.org/
   [rps]:    http://chneukirchen.github.com/rps/
   [style]:  https://github.com/bbatsov/ruby-style-guide
   [gem]:    http://weblog.rubyonrails.org/2009/9/1/gem-packaging-best-practices

Additional facts:

* Written purely in Ruby.
* Intended to be used with Ruby 1.8.7 or higher.
* Cryptographically signed gem and git tags.

Synopsis
--------

This documentation defines the public interface of the software. Don't rely
on elements marked as private. Those should be hidden in the documentation
by default.

### Command-line tool

The default output encoding is unix. You can also choose mac and windows.

    linebreak encode --system windows unix.txt windows.txt

If no target file is specified the output will be sent to STDOUT.

    linebreak encode --system windows mac.txt > windows.txt

You can set the default with the environment variable LINEBREAK_SYSTEM.

    export LINEBREAK_SYSTEM=mac

    linebreak encode windows.txt mac.txt

If you do not specify an output file, output will be put to STDOUT. If you also
do not specify an input file, input will be expected from STDIN.

You can also detect the linebreak systems contained in a file in the following
way:

    linebreak encodings windows_mac.txt

If you want to ensure that a file contains the exact encodings systems you
specified, you can use the following command:

    linebreak encodings --ensure unix,windows,mac unix.txt

The results will be outputted. In case of a file containing other linebreak
encoding systems there will be an exit code of 1.

It is also possible to specify multiple input files or none to expect input from
STDIN.

Requirements
------------

* Ruby 1.8.7 or higher
* user-choices

Installation
------------

On *nix systems you may need to prefix the command with sudo to get root
privileges.

### High security (recommended)

There is a high security installation option available through rubygems. It is
highly recommended over the normal installation, although it may be a bit less
comfortable. To use the installation method, you will need my [gem signing
public key][gemkey], which I use for cryptographic signatures on all my gems.

Add the key to your rubygems' trusted certificates by the following command:

    gem cert --add aef-gem.pem

Now you can install the gem while automatically verifying it's signature by the
following command:

    gem install linebreak-cli -P HighSecurity

Please notice that you may need other keys for dependent libraries, so you may
have to install dependencies manually.

   [gemkey]: http://aef.name/crypto/aef-gem.pem

### Normal

    gem install linebreak-cli

### Automated testing

Go into the root directory of the installed gem and run the following command
to fetch all development dependencies:

    bundle

Afterwards start the test runner:

    rake spec

If something goes wrong you should be noticed through failing examples.

Development
-----------

### Bugs Reports and Feature Requests

Please use the [issue tracker][issues] on github.com to let me know about errors
or ideas for improvement of this software.

   [issues]: https://github.com/aef/linebreak-cli/issues/

### Source code

This software is developed in the source code management system git hosted
at github.com. You can download the most recent sourcecode through the
following command:

    git clone https://github.com/aef/linebreak-cli.git

The final commit before each released gem version will be marked by a tag
named like the version with a prefixed lower-case "v", as required by Semantic
Versioning. Every tag will be signed by my [OpenPGP public key][openpgp] which
enables you to verify your copy of the code cryptographically.

   [openpgp]: http://aef.name/crypto/aef-openpgp.asc

Add the key to your GnuPG keyring by the following command:

    gpg --import aef-openpgp.asc

This command will tell you if your code is of integrity and authentic:

    git tag -v [TAG NAME]

### Contribution

Help on making this software better is always very appreciated. If you want
your changes to be included in the official release, please clone my project
on github.com, create a named branch to commit and push your changes into and
send me a pull request afterwards.

Please make sure to write tests for your changes so that I won't break them
when changing other things on the library. Also notice that I can't promise
to include your changes before reviewing them.

License
-------

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
