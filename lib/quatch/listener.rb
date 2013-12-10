require 'listen' # require listen gem

module Sasquatch
  class Listener
    include Logger
    attr_reader :file, :files, :listener, :status, :base_path, :file_changed, :running

    def initialize file, &block
      @file = file

      @base_path = File.dirname(@file)

      @running = true

      validate_file @file

      find_imports @file

      @file_changed = block

      # init the logger
      logger "Watching '#{@file}' for updates"

      # listen to the main file's directory
      @listener = Listen.to(File.dirname(@file), only: /\.js$/, &hear)
      # start listening
      start
    end

    def find_imports file
      @files = {}
      File.read(file).scan(/\/\* @import .+?(.*.js)/) do |filename|
        @import = "#{File.dirname(@file)}/#{filename.first}"
        validate_file @import
        @files[filename.first] = File.new(File.absolute_path(@import))
      end
    end

    def hear
      Proc.new do |modified, added, removed|
        if(modified)
          modified_file = modified.first
          if(imported? modified_file)
            if(@file_changed)
              @file_changed.call(_get_file_name(modified_file), @file, @files)
            end
          end
        end
      end
    end

    def start
      @listener.start # not blocking
      while( @running ) do
        sleep(1)
      end
    end

    def stop
      @listener.pause
      @running = false
    end

    def validate_file file
      unless(File.file?(file))
        raise "Specified file doesn't exist"
      end
    end

    def imported? file

      filename = _get_file_name file

      if(filename == _get_file_name(@file) or @files.keys.include? filename)
        return true
      end

      false

    end

    def _get_file_name filename
      filename.sub(/^.*?#{@base_path}\//, '')
    end

  end
end