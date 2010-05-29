module RubyBeamer
    def __beamer_get_options(*args)
        return "" if args.empty?

        values = args.inject([]) do |val, arg|
            if (arg.is_a? Hash)
                arg.each_pair {|k, v| val << "#{k}=#{v}" }
            else
                val << arg.to_sym
            end
            val
        end

        return "[" + values.join(",") + "]"
    end

    def __wrap_in_section(type, title, &block)
        create_oneline_block(type) {title}
        content = yield if block
        output content, "\n" if content
        create_oneline_block(type)
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
        content = yield if block
        output content if content
        output "}\n"
    end

    def text
        content = yield
        output content if content
    end

    def new_line
        text { "\\\\" }
    end
end
