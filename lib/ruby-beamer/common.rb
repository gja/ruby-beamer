module RubyBeamer
    class Hash < ::Hash
        def remove_key(key)
            answer = has_key? key
            delete key
            answer
        end

        def pop_entries(*keys)
            keys.inject({}) do |value, key|
                value[key] = self.delete(key) if self.has_key? key
                value
            end
        end

        def set_beamer_arguments_from(*keys)
            interesting = self.pop_entries(*keys)
            self[:arguments] = __beamer_get_options(interesting)
            self
        end
    end

    class ::Array
        def to_beamer_hash
            inject(Hash.new) do |values, arg|
                if(arg.is_a? ::Hash)
                    values.merge! arg
                else
                    values[arg] = nil
                end
                values
            end
        end
    end

    def __beamer_get_options(*args)
        values = args.to_beamer_hash.inject([]) {|values, tuple| values << "#{tuple[0]}#{"=" if tuple[1]}#{tuple[1]}" }
        return "" if values.empty?
        return "[" + values.join(",") + "]"
    end

    def __wrap_in_section(type, title, &block)
        create_oneline_block(type) {title}
        content = yield if block
        output content, "\n" if content
        create_oneline_block(type)
    end

    def __print_block(starting, separator, content_start, ending, args, &block)
        block_args = (args.delete :arguments) || ""
        appear_on = ("<#{args.delete :on}>" if args.has_key? :on) || ""

        output starting, appear_on, block_args, separator, content_start
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
