require 'spec_helper'

describe OSTranslator do
  it "should translate common OS results properly" do
    test_map = {
      "darwin10.6" => "Mac OS X 10.6",
      "darwin10.5" => "Mac OS X 10.5",
      "darwin10.4" => "Mac OS X 10.4",
      "darwin10.3" => "Mac OS X 10.3",
      "darwin10.2" => "Mac OS X 10.2",
      "darwin10.1" => "Mac OS X 10.1",
      "darwin" => "Mac OS X Unknown",
      "darwin10" => "Mac OS X Unknown",
      "linux" => "Linux Unknown",
      "linux-gnu" => "Linux Unknown",
      "freebsd8" => "FreeBSD 8",
      "mingw32" => "Windows (mingw) 32-bit",
      "mswin32" => "Windows (Visual C) 32-bit",
    }

    test_map.keys.each do |orig|
      OSTranslator.translate(orig).should == test_map[orig]
    end
  end
end
