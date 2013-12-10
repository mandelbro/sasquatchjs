# require all files in the directory
# example:
require "quatch/logger"
require "quatch/listener"
require "quatch/compiler"
require "optparse"

module Sasquatch
  class Quatcher
    include Logger
    def initialize *args

      @options = parse_options args





      end


    end



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