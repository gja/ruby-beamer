require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Options to Block" do
    it "Should Return Empty if nothing is passed to it" do
        __beamer_get_options().should() == ""
    end

    it "Should Return Parameters passed to it" do
        __beamer_get_options(:foo => "bar", :baz => 0.8).should == "[foo=bar,baz=0.8]"
        __beamer_get_options(:foo, :bar => "baz").should == "[foo,bar=baz]"
    end

    it "Should be able to generate a beamer hash" do
        array = [:foo, :bar, {:ooga => "ooga", :booga => "booga"}]
        hash = array.to_beamer_hash

        hash.should have_key :foo
        hash[:foo].should be_nil
        hash.should have_key :bar
        hash[:bar].should be_nil
        hash[:ooga].should == "ooga"
        hash[:booga].should == "booga"
    end

    it "Should Be Able to Set Arguments from hash" do
        hash = get_beamer_hash(:foo, :bar, :baz => 3)
        
        hash.set_beamer_arguments_from :foo, :baz
        hash[:arguments].should == "[foo,baz=3]"
    end

    it "Should be able to delete a key if present" do
        hash = [:foo, :bar].to_beamer_hash
        hash.remove_key(:foo).should be_true
        hash.remove_key(:foo).should be_false
    end

    it "Should be able to get interesting elements from the hash" do
        hash = get_beamer_hash(:foo => 1, :bar => 2, :baz => 3)

        interesting = hash.pop_entries :foo, :bar, :spam

        interesting[:foo].should == 1
        interesting[:bar].should == 2

        hash.has_key?(:foo).should be_false
        hash.has_key?(:bar).should be_false
        hash.has_key?(:baz).should be_true
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

    it "Should be able to pass arguments to a beamer block" do
        create_block :document, :arguments => "{foo}"
        printed.should == <<EOF
\\begin{document}{foo}
\\end{document}
EOF
    end

    it "Should be able to print out a string passed to it as a block" do
        create_block(:document) {"foo"}
        printed.should == <<EOF
\\begin{document}
foo
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

describe "Create one line blocks" do
    it "Should be able to create a one line block" do
        create_oneline_block(:em){"foo"}
        printed.should == "\\em{foo}\n"
    end

    it "Should be able to create a one line block" do
        create_oneline_block(:em){nil}
        printed.should == "\\em{}\n"
    end

    it "Should be able to create a one line block with arguments" do
        create_oneline_block(:em, :arguments => "[bar]"){"foo"}
        printed.should == "\\em[bar]{foo}\n"
    end
end

describe "Text Block" do
    it "Should be able to create a text block" do
        text {"foo"}
        printed.should == "foo"
    end

    it "Should be able to print a new line" do
        new_line
        printed.should == "\\\\"
    end
end
