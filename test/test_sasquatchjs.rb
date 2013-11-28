
describe Sasquatch do
  context "#listening" do
    Sasquatch.watch('js/application.js')
    it "should print out the right thing" do
      printer = Printer.new
      fiction = FictionBook.new
      printer.print(fiction).should eq "This book is Fiction!"
    end
  end
end
