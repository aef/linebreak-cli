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

require 'spec_helper'

describe Aef::Linebreak do
  include LinebreakSpecHelper

  let(:unix_fixture)    { "Abcdef\nAbcdef\nAbcdef" }
  let(:windows_fixture) { "Abcdef\r\nAbcdef\r\nAbcdef" }
  let(:mac_fixture)     { "Abcdef\rAbcdef\rAbcdef" }

  context 'commandline tool' do
    describe '"version" command' do
      it 'should display correct version and licensing information with the version argument' do
        `#{executable_path} version`.should eql(version_message)
      end

      it 'should display correct version and licensing information with the --version argument' do
        `#{executable_path} --version`.should eql(version_message)
      end

      it 'should display correct version and licensing information with the -v argument' do
        `#{executable_path} -v`.should eql(version_message)
      end

      it 'should display correct version and licensing information with the -V argument' do
        `#{executable_path} -V`.should eql(version_message)
      end
    end

    describe '"encode" command' do
      it 'should use unix as default format' do
        `#{executable_path} encode #{fixture_path('windows.txt')}`.should eql(unix_fixture)
      end

      it 'should accept -s option to specify output format' do
        `#{executable_path} encode -s mac #{fixture_path('unix.txt')}`.should eql(mac_fixture)
      end

      it 'should also accept --system option to specify output format' do
        `#{executable_path} encode --system windows #{fixture_path('mac.txt')}`.should eql(windows_fixture)
      end

      it 'should abort on invalid output formats' do
        process, stdout, stderr = command("encode -s fnord #{fixture_path('mac.txt')}")
        process.wait
        process.io.stdout.close
        process.io.stderr.close

        stdout.read.should be_empty
        stderr.read.should_not be_empty
      end

      it 'should accept LINEBREAK_SYSTEM environment variable to specify output format' do
        env(:LINEBREAK_SYSTEM => 'mac') do
          `#{executable_path} encode #{fixture_path('windows.txt')}`.should eql(mac_fixture)
        end
      end

      it 'should use output format specified with -s even if LINEBREAK_SYSTEM environment variable is set' do
        env(:LINEBREAK_SYSTEM => 'windows') do
          `#{executable_path} encode -s mac #{fixture_path('unix.txt')}`.should eql(mac_fixture)
        end
      end

      it 'should use a second argument as target file' do
        temp_file = Tempfile.open('linebreak_spec')
        location = Pathname(temp_file.path)
        temp_file.close
        location.unlink

        `#{executable_path} encode --system windows #{fixture_path('unix.txt')} #{location}`.should be_empty

        location.read.should eql(windows_fixture)
        location.unlink
      end
    end

    describe '"encodings" command' do
      it "should correctly detect the linebreak encodings of a file" do
        process, stdout, stderr = command("encodings #{fixture_path('mac.txt')}")
        process.wait        
        process.io.stdout.close
        process.io.stderr.close

        stdout.read.should eql("#{fixture_path('mac.txt')}: mac\n")
        process.exit_code.should eql 0
      end

      it "should correctly detect the linebreak encodings of multiple files" do
        files = %w{unix_windows.txt windows_mac.txt mac_unix.txt unix_windows_mac.txt}
        files = files.map{|file| fixture_path(file)}

        process, stdout, stderr = command("encodings #{files.join(' ')}")
        process.wait
        process.io.stdout.close
        process.io.stderr.close
        process.exit_code.should eql 0

        output = stdout.read
        output.should include("#{files[0]}: unix,windows\n")
        output.should include("#{files[1]}: windows,mac\n")
        output.should include("#{files[2]}: unix,mac\n")
        output.should include("#{files[3]}: unix,windows,mac\n")
      end

      it "should correctly ensure the linebreak encodings of a valid file" do
        process, stdout, stderr = command("encodings --ensure unix #{fixture_path('unix.txt')}")
        process.wait
        process.io.stdout.close
        process.io.stderr.close
        process.exit_code.should eql 0

        stdout.read.should eql "#{fixture_path('unix.txt')}: unix\n"
      end

      it "should correctly ensure the linebreak encodings of an invalid file" do
        process, stdout, stderr = command("encodings --ensure mac #{fixture_path('unix_windows.txt')}")
        process.wait
        process.io.stdout.close
        process.io.stderr.close
        process.exit_code.should eql 1

        stdout.read.should eql "#{fixture_path('unix_windows.txt')}: unix,windows (failed)\n"
      end

      it "should correctly ensure the linebreak encodings of multiple files" do
        files = %w{unix_windows.txt windows_mac.txt mac_unix.txt unix_windows_mac.txt}
        files = files.map{|file| fixture_path(file)}

        process, stdout, stderr = command("encodings --ensure windows,unix #{files.join(' ')}")
        process.wait
        process.io.stdout.close
        process.io.stderr.close
        process.exit_code.should eql 1

        output = stdout.read
        output.should include("#{files[0]}: unix,windows\n")
        output.should_not include("#{files[0]}: unix,windows (failed)\n")
        output.should include("#{files[1]}: windows,mac (failed)\n")
        output.should include("#{files[2]}: unix,mac (failed)\n")
        output.should include("#{files[3]}: unix,windows,mac (failed)\n")
      end
    end
  end
end
