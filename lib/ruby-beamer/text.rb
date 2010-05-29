module RubyBeamer
    def center(&block)
        create_block(:center, &block)
    end

    ONE_LINERS = {
        :bold => :textbf,
        :em => :em,
        :huge => :huge,
        :footnote => :footnotesize,
        :teletype => :tt,
        :structure => :structure,
        :vspace => :vspace
    }

    def method_missing(method, *args, &block)
        return super if not ONE_LINERS.has_key? method
        create_oneline_block(ONE_LINERS[method], &block)
    end

    def responds_to?(method)
        super or ONE_LINERS.has_key? method
    end
end
