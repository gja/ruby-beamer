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

    def __print_block(starting, separator, content_start, ending, args, &block)
        block_args = (args.delete :arguments or "")

        output starting, block_args, separator, content_start
        content = yield if block
        output content, separator if content
        output ending, "\n"
    end

    def create_block(type, args = {}, &block)
        __print_block("\\begin{#{type}}", "\n", "", "\\end{#{type}}", args, &block)
    end

    def create_oneline_block(type, args = {}, &block)
        __print_block("\\#{type}", "", "{", "}", args, &block)
    end

    def text
        content = yield
        output content if content
    end

    def new_line
        text { "\\\\" }
    end
end
