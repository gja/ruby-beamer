module RubyBeamer
    def beamer_document(args = {}, &block)
        theme = args[:theme] || "default"

        output "\\documentclass{beamer}\n"
        output "\\usetheme{#{theme}}\n"

        output "\\setbeamertemplate{navigation symbols}{}\n" if args[:disable_navigation]

        create_block :document, &block
    end
end
