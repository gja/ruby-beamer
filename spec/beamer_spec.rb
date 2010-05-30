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

    it "Should create a block" do
        block("title") { "foo" }
        printed.should == <<-eos
\\begin{block}{title}
foo
\\end{block}
        eos
    end

    it "Should create a resizebox" do
        resize_box(TEXT_WIDTH, TEXT_HEIGHT) { "foo" }
        printed.should == "\\resizebox{\\textwidth}{\\textheight}{foo}\n"
    end

    it "Should be able to create an itemized list" do
        itemized_list do
            item {"First Item"}
            item {"Second Item"}
        end
        printed.should == <<-eos
\\begin{itemize}
\\item{First Item}
\\item{Second Item}
\\end{itemize}
        eos
    end

    it "Should be able to specify which slide an item appears on" do
        item(:on => "1-") {"First Item"}
        printed.should == "\\item<1->{First Item}\n"
    end

    it "Should be possible to pass an item a string" do
        item "string"
        printed.should == "\\item{string}\n"
    end

    it "Should be able to create a title frame" do
        title_frame :plain
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

    it "Should be able to create sections and subsections" do
        section "foo" do
            sub_section "bar" do
                "baz"
            end
        end
        printed.should == <<-eos
\\section{foo}
\\subsection{bar}
baz
        eos
    end

    it "should be able to create a table of contents frame" do
        table_of_contents_frame "Overview", :hideallsubsections, :section => 1
        printed.should == <<-eos
\\begin{frame}{Overview}
\\tableofcontents[hideallsubsections,section=1]{}
\\end{frame}
        eos
    end
end
