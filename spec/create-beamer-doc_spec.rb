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

end
