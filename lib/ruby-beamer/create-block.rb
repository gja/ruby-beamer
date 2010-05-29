def create_block(type, &block)
    print "\\begin{#{type}}\n"
    yield if block
    print "\\end{#{type}}\n"
end
