require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Create Beamer Block" do

    it "should be able to create a beamer block" do
        create_block :document
        printed.should == <<EOF
\\begin{document}
\\end{document}
EOF
    end

    it "Should Be Able to accept another block as parameters" do
        create_block :document do
            create_block :frame
        end

        printed.should == <<EOF
\\begin{document}
\\begin{frame}
\\end{frame}
\\end{document}
EOF
    end
end
