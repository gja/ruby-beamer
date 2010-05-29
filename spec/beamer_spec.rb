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
        printed.should == "\\resizebox{\\textwidth}{\\textheight}{foo}\n"
    end

    it "Should be able to create an itemized list" do
        itemized_list do
            item "First Item"
            item "Second Item"
        end
        printed.should == <<-eos
\\begin{itemize}
\\item{First Item}
\\item{Second Item}
\\end{itemize}
        eos
    end

    it "Should be able to create a title frame" do
        title_frame
        printed.should == <<-eos
\\begin{frame}[plain]
\\titlepage
\\end{frame}
        eos
    end

    it "Should be able to create an image" do
        image("foo.png")
        printed.should == "\\includegraphics{foo.png}\n"
    end

    it "Should be able to set height and width" do
        image("foo.png", :height => "10", :width => "10")
        printed.should == "\\includegraphics[height=10,width=10]{foo.png}\n"
    end

    it "Should be able to center some text" do
        center{"text"}
        printed.should == <<-eos
\\begin{center}
text
\\end{center}
        eos
    end
end
