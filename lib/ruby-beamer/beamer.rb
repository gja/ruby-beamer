module RubyBeamer
    def frame(title = nil, &block)
        create_block(:frame, :arguments => "{#{title}}", &block)
    end

    def block(title, &passed_block)
        create_block(:block, :arguments => "{#{title}}", &passed_block)
    end

    def resize_box(width, height, &block)
        create_oneline_block(:resizebox, :arguments => "{#{width}}{#{height}}", &block)
    end 
    
    def itemized_list(&block)
        create_block(:itemize, &block)
    end

    def item(*args, &block)
        text = args.shift if args[0].is_a? String
        block = lambda { text } if text
        create_oneline_block(:item, args.to_beamer_hash, &block)
    end

    def title_frame(*args)
        create_block(:frame, :arguments => __beamer_get_options(*args)) { "\\titlepage" }
    end

    def table_of_contents_frame(title, *arguments)
        frame(title) { create_oneline_block(:tableofcontents, :arguments => __beamer_get_options(*arguments)) }
    end

    def image(path, *arguments)
        image_properties = __beamer_get_options(*arguments)
        create_oneline_block(:includegraphics, :arguments => image_properties) { path }
    end

    def section(title, &block)
        __wrap_in_section(:section, title, &block)
    end

    def sub_section(title, &block)
        __wrap_in_section(:subsection, title, &block)
    end
end
