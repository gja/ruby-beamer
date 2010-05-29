module RubyBeamer
    def frame(title, &block)
        create_block(:frame, :arguments => "{#{title}}", &block)
    end

    def resize_box(width, height, &block)
        create_oneline_block(:resizebox, :arguments => "{#{width}}{#{height}}", &block)
    end 
    
    def itemized_list(&block)
        create_block(:itemize, &block)
    end

    def item(string)
        create_oneline_block(:item) { string }
    end

    def title_frame
        create_block(:frame, :arguments => "[plain]") { "\\titlepage" }
    end
end
