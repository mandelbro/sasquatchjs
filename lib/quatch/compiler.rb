
module Sasquatch
  class Compiler
    include Logger
    attr_accessor :ext

    def initialize ext
      # set the default extension for compiled files
      @ext = ext
    end

    # compiles files into the specified file
    def compile(files, file)

      # setup the output buffer with the base file
      output_buffer = File.read(File.path(file))

      # loop through import files and substitute imports
      files.each do |key, import_file|
        output_buffer = import(output_buffer, key, import_file)
      end

      File.open(output_filename(file), 'w') do |file|
        file.write(output_buffer)
      end
    end
  end
end