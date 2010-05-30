module RubyBeamer
    def center(*args, &block)
        create_block(:center, args.to_beamer_hash, &block)
    end

    ONE_LINERS = {
        :bold => :textbf,
        :em => :em,
        :huge => :huge,
        :footnote => :footnotesize,
        :teletype => :tt,
        :structure => :structure,
        :vspace => :vspace,
        :only => :only
    }

    def method_missing(method, *args, &block)
        return super if not ONE_LINERS.has_key? method
        create_oneline_block(ONE_LINERS[method], args.to_beamer_hash, &block)
    end

    def responds_to?(method)
        super or ONE_LINERS.has_key? method
    end
end
