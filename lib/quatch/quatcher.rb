# require all files in the directory
# example:
require "quatch/logger"
require "quatch/listener"
require "quatch/compiler"
require "optparse"

module Sasquatch
  class Quatcher
    include Logger
    attr_reader :options, :listeners, :compiler

    def initialize *args

      @options = parse_options args

      @listeners = []

      @options[:files].each do |file|

        @listeners << Listener.new(file, &file_changed)

      end

      @compiler = Compiler.new('.min.js')

    end

    def file_changed
      Proc.new do |modified_file, file, files|

        @compiler.compile(files, file)

        logger "Sasquatch has detected a change to #{modified_file}, recompiling..."
      end
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

  end
end