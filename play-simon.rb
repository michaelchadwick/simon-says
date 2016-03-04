#!/usr/bin/env ruby -w
# encoding: UTF-8

require 'optparse'
require_relative 'simon'

SIMON_LEVEL_DEFAULT = 1 # ms

def parse_options
  options = {
    difficulty: SIMON_LEVEL_DEFAULT
  }

  optparse = OptionParser.new do |opts|
    opts.banner = 'Simon Says! Repeat the pattern back to Simon'
    opts.banner = 'usage: ruby play-simon.rb [-difficulty 1|2|3]'

    opts.on('-d', '--difficulty DIFFICULTY', 'Difficulty level: controls how fast the pattern is revealed') do |d|
      options[:difficulty] = d
    end

    opts.on('-h', '-?', '--help', 'Display this screen and exit') do
      puts opts
      exit
    end
  end

  optparse.parse!

  return options
end

begin
  options = parse_options

  new_game = Simon.new(options)
  new_game.play
rescue => e
  puts "Error: #{e}"
end
