module RubyBeamer
    def beamer_document(args = {}, &block)
        theme = args[:theme] || "default"
        global_options = args[:global_options]

        output "\\documentclass", ("[#{global_options}]" if global_options) || "", "{beamer}\n"
        output "\\usetheme{#{theme}}\n"

        output "\\setbeamertemplate{navigation symbols}{}\n" if args[:disable_navigation]

        create_block :document, &block
    end
end
