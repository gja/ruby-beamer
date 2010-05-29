require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Create Beamer Document" do

    it "should be able to create a default beamer document" do
        beamer_document
        printed.should == <<EOF
\\documentclass{beamer}
\\usetheme{default}
\\begin{document}
\\end{document}
EOF
        end

    it "should be able to set the theme" do
        beamer_document(:theme => :warsaw)
        printed.should include "\\usetheme{warsaw}\n"
    end

    it "Should be able to disable navigation" do
        beamer_document(:disable_navigation => true)
        printed.should include "\\setbeamertemplate{navigation symbols}{}\n"
    end

    it "should be possible to pass a block to document" do
        beamer_document do
            create_block :frame
        end
        printed.should == <<EOF
\\documentclass{beamer}
\\usetheme{default}
\\begin{document}
\\begin{frame}
\\end{frame}
\\end{document}
EOF
    end

    it "Should be possible to pass global options to the document" do
        beamer_document :global_options => "table"
        printed.should include "\\documentclass[table]{beamer}"
    end

    it "Should be able to set the title" do
        beamer_document :title => "title"
        printed.should include "\\title{title}\n"
    end

    it "Should be able to set the subtitle" do
        beamer_document :subtitle => "title"
        printed.should include "\\subtitle{title}\n"
    end

    it "Should be able to set the title" do
        beamer_document :author => "title"
        printed.should include "\\author{title}\n"
    end

    it "Should be able to set the title" do
        beamer_document :date => "title"
        printed.should include "\\date{title}\n"
    end

    it "Should be able to set a short and long title" do
        beamer_document :title => ["short", "title"]
        printed.should include "\\title[short]{title}\n"
    end

end
