module RubyBeamer
    def __beamer_get_options(args = nil)
        return "" if not args
        return "" if args.empty?

        values = []
        args.each_pair{|k, v| values << "#{k}=#{v}" }
        return "[" + values.join(",") + "]"
    end

    def create_block(type, &block)
        print "\\begin{#{type}}\n"
        content = yield if block
        print content, "\n" if content
        print "\\end{#{type}}\n"
    end
end
