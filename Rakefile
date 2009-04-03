# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/breakverter.rb'

Hoe.new('breakverter', BreakVerter::VERSION) do |p|
  p.rubyforge_name = 'aef'
  p.developer('Alexander E. Fischer', 'aef@raxys.net')
  p.extra_dev_deps = %w{rspec user-choices sys-uname}
  p.url = 'https://rubyforge.org/projects/aef/'
  p.spec_extras = {
    :rdoc_options => ['--main', 'README.txt', '--inline-source', '--line-numbers', '--title', 'BreakVerter']
  }
end

# vim: syntax=Ruby
