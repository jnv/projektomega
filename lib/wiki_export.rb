#!/usr/bin/env ruby
require "erb"

# first try and show proper usage if arguments aren't well-formed:
def usage
  abort "usage: script/rails runner -e production scripts/#{__FILE__} -- [options]"
end

# not using script/rails runner?
usage unless Object.const_defined?(:Rails)

# missing the argument delimiter?
# usage unless ARGV.include?("--")

# # now, clean up ARGV:
# loop { break if ARGV.shift == "--" }

OUT_DIR = 'wiki_export'

# your code here, with a clean ARGV
char_tpl = ERB.new(File.read('lib/wiki_export/agent.erb'))
char_dir = File.join(OUT_DIR, 'agenti')
FileUtils.mkdir_p char_dir
Character.all.each do |char|
  @character = char
  File.open("#{char_dir}/#{char.number}.txt", 'w') do |f|
    f << char_tpl.result(binding)
  end
end

mission_tpl = ERB.new(File.read('lib/wiki_export/mise.erb'))
mission_dir = File.join(OUT_DIR, 'mise')
FileUtils.mkdir_p mission_dir
Mission.all.each do |mission|
  @mission = mission
  File.open("#{mission_dir}/#{mission.number}.txt", 'w') do |f|
    f << mission_tpl.result(binding)
  end
end
