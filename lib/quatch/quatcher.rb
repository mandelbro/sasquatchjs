# require all files in the directory
# example:
require "quatch/logger"
require "quatch/listener"
require "quatch/compiler"
require "optparse"

module Sasquatch
  class Quatcher
    attr_accessor :files, :status, :options
    attr_reader :listener, :running
    def initialize *args

      @options = parse_options args
      @running = true

      @options[:files].each do |file|
        unless(File.file?(file))
          raise "Specified file doesn't exist"
        end

        find_imports(file)

        # init the logger
        logger "Watching '#{file}' for updates"

        listen(File.dirname(file))

      end

    end

    def find_imports file
      @files = {}
      File.read(file).scan(/\/\* @import (.*.js)/) do |filename|
        @files[filename.first] = File.absolute_path(filename.first)
      end
    end

    def listen dir
      # setup the listener on the main file's directory
      @listener = Listen.to(dir, only: /\.js$/) do |modified, added, removed|
        file_changed modified
        p @files
        stop_listener
      end
      # start the listener
      start_listener
    end

    def listener_callback
      Proc.new do |modified, added, removed|
        file_changed modified
        p @files
        stop_listener
      end
    end

    def start_listener
      # start listening
      @listener.start # not blocking
      while (@running)
        sleep(2)
      end
    end

    def stop_listener
      @listener.stop
      # @running = false
    end

    def file_changed

      logger "modified absolute path: #{modified}"
    end

    def parse_options(argv)
      params = {}
      parser = OptionParser.new

      parser.on("-n") { params[:line_numbering_style] ||= :all_lines         }
      parser.on("-b") { params[:line_numbering_style]   = :significant_lines }
      parser.on("-s") { params[:squeeze_extra_newlines] = true               }

      params[:files] = parser.parse(argv)

      params
    end

    def init_logger
      # create the log file
    end

    def logger message
      @status = message
      print_line message
      STDOUT.flush
    end

    def print_line(line)
      print "\s\s#{line.to_s.rjust(6)}\n"
    end
  end
end