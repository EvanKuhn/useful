require 'optparse'

# Use this template for full option parsing capabilities, using just the
# optparse gem.
#
# To use, copy this file, take care of all the TODO's, and add your application
# logic.

#===============================================================================
# Application usage info strings
#===============================================================================

# TODO: update app name
APPNAME = 'myapp'

# TODO: update the header
HEADER = <<-STR
#{APPNAME}

DESCRIPTION
    description description description description description description
    description description description description description description
    description description description description description description

USAGE
    #{APPNAME} [options]
STR

# TODO: update the footer
FOOTER = <<-STR
FOOTER
    footer footer footer footer footer footer footer footer footer footer
    footer footer footer footer footer footer footer footer footer footer
STR

#===============================================================================
# Argument parser and usage info class
#===============================================================================

module MyApp
  class Arguments
    attr_reader :key, :flag, :help

    # Initialize the option parses
    def initialize
      @parser = OptionParser.new do |opts|
        opts.summary_width = 24
        opts.separator ''
        opts.separator 'OPTIONS'
        opts.banner = ''

        # TODO: update options
        opts.on('-k', '--key VALUE', 'An option that takes a value') do |v|
          @key = v
        end
        opts.on('-f', '--flag', 'A boolean flag') do
          @flag = true
        end
        opts.on('-h', '--help', 'Display this screen.') do
          @help = true
        end
      end
    end

    # Get the usage info string
    def usage
      HEADER.chomp + @parser.to_s + "\n" + FOOTER
    end

    # Parse an arguments array and return a new Arguments object
    def self.parse(argv)
      Arguments.new.parse(argv)
    end

    # Parse an arguments array and populate this Arguments object.
    # - Will print usage info and exit if help is requested.
    # - Will print an error message and abort if required inputs are missing.
    def parse(argv)
      # Work off a copy of the arg array
      argv = argv.dup

      # Parse options and check for errors, or a help request
      print_usage_and_exit if argv.empty?
      @parser.parse!(argv)
      print_usage_and_exit if self.help

      # Return self
      self
    end

    # Does what you think
    def print_usage_and_exit
      puts usage
      exit
    end
  end
end

#===============================================================================
# Application
#===============================================================================

module MyApp
  class Application
    def self.run(argv = ARGV)
      # Get the command-line args
      args = Arguments.parse(argv)
      args.print_usage_and_exit if args.help

      # TODO: application logic here
      puts "running your application with key=#{args.key.inspect}, flag=#{args.flag.inspect}"

    rescue OptionParser::InvalidOption, OptionParser::MissingArgument, ArgumentError => e
      abort "#{APPNAME}: #{e.message}"
    end
  end
end

#TODO: remove
MyApp::Application.run
