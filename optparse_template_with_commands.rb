require 'optparse'



# Use this template for full option parsing capabilities, with commands, using
# just the optparse gem.




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
    #{APPNAME} <command> [options]
STR

# TODO: update commands
COMMANDS = [:foo, :bar, :bat]

# TODO: update the footer
FOOTER = <<-STR
COMMANDS
    foo     foo foo foo foo foo foo foo foo foo foo
    bar     bar bar bar bar bar bar bar bar bar bar bar bar bar bar bar bar
            bar bar bar bar bar bar bar bar bar
    bat     bat bat bat bat bat bat

WHATEVER
    some other stuff some other stuff some other stuff some other stuff some
    other stuff some other stuff some other stuff some other stuff
STR

#===============================================================================
# Argument parser and usage info class
#===============================================================================

module MyApp
  class Arguments
    attr_reader :command, :key, :flag, :help

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

      # Ensure that a valid command was specified
      if argv.empty?
        abort "#{APPNAME}: command required"
      end
      @command = argv.shift.to_sym
      unless COMMANDS.include?(command)
        abort "#{APPNAME}: unknown command: #{command}"
      end

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

      # Check if the command is supported
      unless COMMANDS.include? args.command
        abort "#{APPNAME}: unknown command: #{args.command}"
      end
      handler = "run_command__#{args.command}"
      unless respond_to? handler
        abort "#{APPNAME}: no handler available for for command: #{args.command}"
      end

      # Run the command's handler function
      send(handler, args)
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument, ArgumentError => e
      abort "#{APPNAME}: #{e.message}"
    end

    private

    # Handler for the 'foo' command
    def self.run_command__foo(args)
      puts "Running command '#{args.command}' with key=#{args.key.inspect}, flag=#{args.flag.inspect}"
    end

    # Handler for the 'bar' command
    def self.run_command__bar(args)
      puts "Running command '#{args.command}' with key=#{args.key.inspect}, flag=#{args.flag.inspect}"
    end
  end
end

#TODO: remove
MyApp::Application.run
