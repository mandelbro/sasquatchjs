require "sasquatchjs"

describe Sasquatch do

  context "#initialization" do
    # it should have a watch method that accepts a file as an argument
    it "should accept a valid file" do
      expect { Sasquatch.watch('test/js/application.js') }.to_not raise_exception
    end
    # it should have a watch method that accepts a file as an argument
    it "should raise and exception on an invalid file" do
      expect { Sasquatch.watch('test/js/error') }.to raise_exception
    end
    # it should throw an error if the provided file is invalid
    it "it should tell me what file is being watched" do
      expect(Sasquatch.watch('test/js/application.js').status).to eq "Watching 'test/js/application.js' for updates"
    end
  end

  context "#listening" do
    sasquatch = Sasquatch.watch('test/js/application.js')
    # it should have a list of all imported files
    it "it should have a list of all imported files" do
      files = {
        "test.js" => "/Users/chrismontes/Ruby/gems/sasquatchjs/test.js",
        "test-2.js" => "/Users/chrismontes/Ruby/gems/sasquatchjs/test-2.js"
      }
      expect(sasquatch.files).to eq files
    end
    # it should start listening to a valid file
    it "it should start listening to a valid file" do
    end
    # it should throw an error if any of the imported files are invalid
    it "it should throw an error if any of the imported files are invalid"
    # it should listen to all the imported files
    it "it should listen to all the imported files"
  end

  context "#compiling" do
    # it should write a new file when a file is watched
    it "it should write a new file when a file is watched"
    # it should write a new file when the primary file is changed
    it "it should write a new file when the primary file is changed"
    # it should write a new file when any of the import files are changed
    it "it should write a new file when any of the import files are changed"
  end

end
