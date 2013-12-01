require "sasquatchjs"

describe Sasquatch do

  context "#initialization" do
    sasquatch = Sasquatch.watch('js/application.js')
    # it should have a watch method that accepts a file as an argument
    it "should accept a valid file" do
      Sasquatch.watch('js/application.js').should eq "Watching #{File.dirname(__FILE__)}/application.js"
    end
    # it should throw an error if the provided file is invalid
    it "it should throw an error if the provided file is invalid" do
      expect { Sasquatch.watch('js/naught.js') }.to raise_error
    end
  end

  context "#listening" do
    # it should start listening to a valid file
    it "it should start listening to a valid file" do
    end
    # it should know the line number and relative path of all imported files
    it "it should know the line number and relative path of all imported files" do
    end
    # it should throw an error if any of the imported files are invalid
    it "it should throw an error if any of the imported files are invalid" do
    end
    # it should listen to all the imported files
    it "it should listen to all the imported files" do
    end
  end

  context "#compiling" do
    # it should write a new file when a file is watched
    it "it should write a new file when a file is watched" do
    end
    # it should write a new file when the primary file is changed
    it "it should write a new file when the primary file is changed" do
    end
    # it should write a new file when any of the import files are changed
    it "it should write a new file when any of the import files are changed" do
    end
  end

end
