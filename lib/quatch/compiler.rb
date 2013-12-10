
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

    def output_filename file

      filename = ""
      file.scan(/^(.*?)\./) do |basename|
        filename = basename.first + @ext
      end

      (filename == file ? filename + @ext : filename)

    end

    # search the output buffer for the key and replace it with the import_file
    def import output_buffer, key, import_file
      output_buffer.sub(/\/\* @import #{key} \*\//, "/* Imports #{key} */ \n\n" + File.read(import_file.path()) + "\n")
    end

  end
end