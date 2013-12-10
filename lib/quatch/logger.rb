module Sasquatch
  module Logger
    def logger message
      @status = message
      print_line message
      STDOUT.flush
    end

    def print_line(line)
      puts "\s\s#{line.to_s.rjust(6)}"
    end
  end
end