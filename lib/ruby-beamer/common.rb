module RubyBeamer
    def __beamer_get_options(args = nil)
        return "" if not args
        return "" if args.empty?

        values = []
        args.each_pair{|k, v| values << "#{k}=#{v}" }
        return "[" + values.join(",") + "]"
    end

    def create_block(type, &block)
        output "\\begin{#{type}}\n"
        content = yield if block
        output content, "\n" if content
        output "\\end{#{type}}\n"
    end
end
