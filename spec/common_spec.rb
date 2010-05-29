require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Options to Block" do
    it "Should Return Empty if nothing is passed to it" do
        __beamer_get_options(nil).should() == ""
        __beamer_get_options({}).should() == ""
    end

    it "Should Return Parameters passed to it" do
        __beamer_get_options(:foo => "bar", :baz => 0.8).should == "[foo=bar,baz=0.8]"
    end
end

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
