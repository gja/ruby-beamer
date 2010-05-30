require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Text Methods" do
    it "Should be able to center some text" do
        center{"text"}
        printed.should == <<-eos
\\begin{center}
text
\\end{center}
        eos
    end

    it "Should be able write bold text" do
        bold {"First Item"}
        printed.should == "\\textbf{First Item}\n"
    end

    it "Should be able to write emphasized text" do
        em {"Text"}
        printed.should == "\\em{Text}\n"
    end

    it "Should be able to write huge text" do
        huge { "Text" }
        printed.should == "\\huge{Text}\n"
    end

    it "Should be able to write footnotes" do
        footnote { "Text" }
        printed.should == "\\footnotesize{Text}\n"
    end

    it "Should be able to write teletype" do
        teletype { "Text" }
        printed.should == "\\tt{Text}\n"
    end

    it "Should be able to write a structure" do
        structure { "Text" }
        printed.should == "\\structure{Text}\n"
    end

    it "Should be able to draw a vspace" do
        vspace { "2cm" }
        printed.should == "\\vspace{2cm}\n"
    end

    it "Should be able to pass a show_on argument to em" do
        em (:on => "5-") { "text" }
        printed.should == "\\em<5->{text}\n"
    end
end
