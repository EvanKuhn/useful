#!/usr/bin/env ruby

require 'optparse'

#===============================================================================
# Usage info and option parsing
#===============================================================================

BANNER = <<-STR
USAGE:
    #{File.basename(__FILE__)} [options]

DESCRIPTION:
    Do some stuff.

OPTIONS:
STR

opts = {}
parser = OptionParser.new do |parser|
  parser.banner = BANNER
  parser.summary_width = 24

  parser.on('-k', '--key VALUE', 'An option that takes a value') do |v|
    opts[:key] = v
  end
  parser.on('-f', '--flag', 'A boolean flag') do
    opts[:flag] = true
  end
  parser.on('-v', '--[no-]verbose', 'Toggle verbose output') do |v|
    opts[:verbose] = v
  end
  parser.on('-h', '--help', 'Display this screen.') do
    puts parser
    exit
  end
end

if ARGV.empty?
  puts parser
  exit
end

parser.parse!

#===============================================================================
# Main
#===============================================================================

puts "In main, got options: #{opts.inspect}"
