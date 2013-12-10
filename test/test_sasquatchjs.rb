require "sasquatchjs"

describe Sasquatch do

  context "#initialization" do
    # it should accept a valid file
    it "should accept a valid file" do
      expect {
        @thread = Thread.new { Sasquatch.watch('test/js/application.js') }
        @thread.abort_on_exception = true
        sleep(1)
        @thread.exit
      }.to_not raise_exception
    end
      expect { Sasquatch.watch('test/js/error') }.to raise_exception
    # it should raise an exception on an invalid file
    it "should raise an exception on an invalid file" do
    end
      expect(Sasquatch.watch('test/js/application.js').status).to eq "Watching 'test/js/application.js' for updates"
    # it should raise an exception if any of the imported files are invalid
    it "should raise an exception if any of the imported files are invalid" do
    end
  end

  context "#Listener" do
    listener = Sasquatch::Listener.new('test/js/application.js')
    # it should have a list of all imported files
      files = {
        "test.js" => "/Users/chrismontes/Ruby/gems/sasquatchjs/test.js",
        "test-2.js" => "/Users/chrismontes/Ruby/gems/sasquatchjs/test-2.js"
      }
      expect(sasquatch.files).to eq files
    it "should have a list of all imported files" do
    end
    # it should start listening to a valid file
    it "should listen to changes to the initilized file" do
    # should listen to changes to the imported files
    it "should listen to changes to the imported files" do
    end
  end

  context "#compiler" do
    # it should write a new file when the primary file is changed
    it "should write a new file appended with .min.js when the primary file is changed" do
    # it should write a new file when any of the import files are changed
    it "should add the imported files into the compiled file when a file is changed" do
  end

end
