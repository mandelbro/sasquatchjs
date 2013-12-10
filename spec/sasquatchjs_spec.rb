require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SasquatchJS" do

  context "#initialization" do
    # it should accept a valid file
    it "should accept a valid file" do
      expect {
        @thread = Thread.new { Sasquatch.watch('spec/js/application.js') }
        @thread.abort_on_exception = true
        STDOUT.flush
        sleep(1)
        @thread.exit
      }.to_not raise_exception
    end
    # it should raise an exception on an invalid file
    it "should raise an exception on an invalid file" do
      expect {
        @thread = Thread.new { Sasquatch.watch('spec/js/error') }
        @thread.abort_on_exception = true
        STDOUT.flush
        sleep(2)
        @thread.exit
      }.to raise_exception
    end
    # it should raise an exception if any of the imported files are invalid
    it "should raise an exception if any of the imported files are invalid" do
      expect {
        @thread = Thread.new { Sasquatch.watch('spec/js/import_error.js') }
        @thread.abort_on_exception = true
        STDOUT.flush
        sleep(3)
        @thread.exit
      }.to raise_exception
    end
    # it should tell me what file is being watched
    it "should tell me what file is being watched" do
      sleep(4)
      STDOUT.should_receive(:puts).and_return("Watching 'spec/js/application.js' for updates")
      @thread = Thread.new { Sasquatch.watch('spec/js/application.js') }
      @thread.abort_on_exception = true
      STDOUT.flush
      sleep(5)
      @thread.exit
    end
  end

  context "#Listener" do
    listener = Sasquatch::Listener.new('spec/js/application.js', false)
    # it should have a list of all imported files
    it "should have a list of all imported files" do
      files = ["test.js", "test-2.js"]
      expect(listener.files.keys).to eq files
    end
    sleep(6)
    @thread = Thread.new { Sasquatch.watch('spec/js/application.js') }
    @thread.abort_on_exception = true
    # it should start listening to a valid file
    it "should listen to changes to the initilized file" do
      sleep(7)
      STDOUT.should_receive(:puts).and_return("Sasquatch has detected a change to spec/js/application.js, recompiling...")
      File.write(f = 'spec/js/application.js', File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))
      sleep(7)
    end
    # should listen to changes to the imported files
    it "should listen to changes to the imported files" do
      sleep(8)
      STDOUT.should_receive(:puts).and_return("Sasquatch has detected a change to spec/js/test.js, recompiling...")
      File.write(f = File.path('spec/js/test.js'), File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))
      sleep(8)
    end
    @thread.exit
  end

  context "#compiler" do
    @thread = Thread.new { Sasquatch.watch('spec/js/application.js') }
    @thread.abort_on_exception = true
    sleep(9)
    # it should write a new file when the primary file is changed
    it "should write a new file appended with .min.js when the primary file is changed" do
      File.write(f = File.path('spec/js/application.js'), File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))
      expect(File.file?('spec/js/application.min.js')).to eq true
    end
    sleep(10)
    # it should write a new file when any of the import files are changed
    it "should add the imported files into the compiled file when a file is changed" do
      File.write(f = File.path('spec/js/test.js'), File.read(f).gsub(/\n.*line added by rspec|\n{1}\z/, "\n // #{Time.now} line added by rspec"))

      sleep(10)

      @import_file = File.read(File.path('spec/js/test.js'))

      expect(File.read(File.path('spec/js/application.min.js')).index(@import_file)).to_not eq nil

    end

    sleep(12)
    @thread.exit
  end

end
