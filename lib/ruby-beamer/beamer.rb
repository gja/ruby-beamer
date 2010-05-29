module RubyBeamer
    def frame(title, &block)
        create_block(:frame, :arguments => "{#{title}}", &block)
    end

    def resize_box(width, height, &block)
        create_block(:resizebox, :arguments => "{#{width}}{#{height}}", &block)
    end
end
