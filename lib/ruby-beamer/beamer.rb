module RubyBeamer
    def frame(title = nil, *args, &block)
        create_block(:frame, args.to_beamer_hash.merge!(:arguments => "{#{title}}"), &block)
    end

    def block(title, *args, &passed_block)
        create_block(:block, args.to_beamer_hash.merge!(:arguments => "{#{title}}"), &passed_block)
    end

    def resize_box(width, height, *args, &block)
        create_oneline_block(:resizebox, args.to_beamer_hash.merge!(:arguments => "{#{width}}{#{height}}"), &block)
    end 
    
    def itemized_list(*args, &block)
        create_block(:itemize, args.to_beamer_hash, &block)
    end

    def item(*args, &block)
        text = args.shift if args[0].is_a? String
        block = lambda { text } if text
        create_oneline_block(:item, args.to_beamer_hash, &block)
    end

    def title_frame(*args)
        hash = args.to_beamer_hash
        hash.set_beamer_arguments_from :plain
        create_block(:frame, hash) { "\\titlepage" }
    end

    def table_of_contents_frame(title, *arguments)
        hash = arguments.to_beamer_hash
        hash.set_beamer_arguments_from :currentsection, :hideothersubsections, :section, :hideallsubsections
        frame(title) { create_oneline_block(:tableofcontents, hash) }
    end

    def image(path, *arguments)
        hash = arguments.to_beamer_hash
        hash.set_beamer_arguments_from(:width, :height)
        create_oneline_block(:includegraphics, hash) { path }
    end

    def section(title, &block)
        __wrap_in_section(:section, title, &block)
    end

    def sub_section(title, &block)
        __wrap_in_section(:subsection, title, &block)
    end
end
