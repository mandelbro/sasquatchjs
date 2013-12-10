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
    # it should raise an exception on an invalid file
    it "should raise an exception on an invalid file" do
      expect {
        @thread = Thread.new { Sasquatch.watch('test/js/error') }
        @thread.abort_on_exception = true
        sleep(1)
        @thread.exit
      }.to raise_exception
    end
    # it should raise an exception if any of the imported files are invalid
    it "should raise an exception if any of the imported files are invalid" do
      expect {
        @thread = Thread.new { Sasquatch.watch('test/js/import_error.js') }
        @thread.abort_on_exception = true
        sleep(1)
        @thread.exit
      }.to raise_exception
    end
    # it should tell me what file is being watched
    it "should tell me what file is being watched" do
      @thread = Thread.new { Sasquatch.watch('test/js/application.js') }
      @thread.abort_on_exception = true
      STDOUT.should_receive(:puts).and_return("Watching 'test/js/application.js' for updates")
      sleep(1)
      @thread.exit
    end
  end

  context "#Listener" do
    listener = Sasquatch::Listener.new('test/js/application.js')
    # it should have a list of all imported files
    it "should have a list of all imported files" do
      files = ["test.js", "test-2.js"]
      expect(listener.files.keys).to eq files
    end
    sleep(1)
    @thread = Thread.new { Sasquatch.watch('test/js/application.js') }
    @thread.abort_on_exception = true
    sleep(1)
    # it should start listening to a valid file
    it "should listen to changes to the initilized file" do
      File.write(f = 'test/js/application.js', File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))
      STDOUT.should_receive(:puts).and_return("Sasquatch has detected a change to test/js/application.js, recompiling...")
      sleep(1)
    end
    # should listen to changes to the imported files
    it "should listen to changes to the imported files" do
      File.write(f = File.path('test/js/test.js'), File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))
      STDOUT.should_receive(:puts).and_return("Sasquatch has detected a change to test/js/test.js, recompiling...")
      sleep(1)
    end
  end

  context "#compiler" do
    # it should write a new file when the primary file is changed
    it "should write a new file appended with .min.js when the primary file is changed" do
    # it should write a new file when any of the import files are changed
    it "should add the imported files into the compiled file when a file is changed" do
  end

end
