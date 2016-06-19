#!/usr/bin/env ruby -w
# encoding: UTF-8

require 'io/console'

# simon says and you respond
class Simon
  SIMON_SPEED_DEFAULT   = 1.0  # secs
  SIMON_SPEED_MODERATE  = 0.5  # secs
  SIMON_SPEED_HARD      = 0.25 # secs

  attr_accessor :pattern_speed,
                :pattern_source,
                :pattern_success_count

  def initialize(options)
    case options[:difficulty]
    when 1
      self.pattern_speed = SIMON_SPEED_DEFAULT
    when 2
      self.pattern_speed = SIMON_SPEED_MODERATE
    when 3
      self.pattern_speed = SIMON_SPEED_HARD
    end

    self.pattern_source = "0123456789".split("")
    self.pattern_success_count = 0
  end

  def play
    success_count = 0
    pattern = ""
    loop do
      pattern << pattern_source.sample
      print "Simon Says..."
      sleep(self.pattern_speed)

      pattern.each_char do |l|
        print l
        sleep(self.pattern_speed)
        print "\b"
        sleep(self.pattern_speed/2)
      end
      print "?\n"

      print "Enter pattern: "
      index = 0
      round_success = true

      while round_success do
        c = STDIN.getch
        print c
        if c != pattern[index]
          round_success = false
          puts
          puts 'INCORRECT! You didn\'t do as Simon Says!'
          puts '---'
          print "You lasted #{success_count} round(s)! "

          case
          when success_count >= 10
            print 'Nice job!'
          when success_count >= 5
            print 'Not bad!'
          when success_count < 5
            print 'You can do better!'
          end

          puts

          return
        end

        break if index + 1 == pattern.length

        index += 1
      end

      print "\r"
      puts "EXCELLENT! Now, do as Simon Says!"
      success_count += 1
    end
  end
end
