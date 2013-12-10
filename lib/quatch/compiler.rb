
module Sasquatch
  class Compiler
    include Logger
    attr_accessor :ext

    def initialize ext
      # set the default extension for compiled files
      @ext = ext
    end
  end
end