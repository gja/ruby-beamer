require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Beamer Methods" do
    it "Should create a frame" do
        frame("title") { "foo" }
        printed.should == <<-eos
\\begin{frame}{title}
foo
\\end{frame}
        eos
    end

    it "Should create a resizebox" do
        resize_box(TEXT_WIDTH, TEXT_HEIGHT) { "foo" }
        printed.should == <<-eos
\\begin{resizebox}{\\textwidth}{\\textheight}
foo
\\end{resizebox}
        eos
    end
end
