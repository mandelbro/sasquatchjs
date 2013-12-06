require 'listen'
require 'quatch/quatcher'

module Sasquatch
  # Sasquatch to file system modifications on a either single directory or multiple directories.
  #
  # @param (see Sasquatch::Quatcher#new)
  #
  # @return [Sasquatch::Quatcher] the listener
  #
  def self.watch(*args, &block)
    Quatcher.new(*args)
  end
end