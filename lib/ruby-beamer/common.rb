module RubyBeamer
    def __beamer_get_options(args = nil)
        return "" if not args
        return "" if args.empty?

        values = []
        args.each_pair{|k, v| values << "#{k}#{"=" if v}#{v}" }
        return "[" + values.join(",") + "]"
    end

    def create_block(type, args = {}, &block)
        arguments = args[:arguments] || ""
        output "\\begin{#{type}}", arguments, "\n"
        content = yield if block
        output content, "\n" if content
        output "\\end{#{type}}\n"
    end

    def create_oneline_block(type, args = {}, &block)
        arguments = args[:arguments] || ""
        output "\\#{type}#{arguments}{"
        output yield if block
        output "}\n"
    end
end
