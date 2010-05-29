module RubyBeamer
    def __get_property_options(properties)
        return nil if not properties
        return "{#{properties}}" if properties.is_a? String
        return "[#{properties[0]}]{#{properties[1]}}"
    end

    def __output_line_from(args, property)
        options = __get_property_options args[property]
        output "\\#{property}#{options}\n" if options
    end

    def beamer_document(args = {}, &block)
        theme = args[:theme] || "default"
        global_options = args[:global_options]

        output "\\documentclass", ("[#{global_options}]" if global_options) || "", "{beamer}\n"
        output "\\usetheme{#{theme}}\n"

        __output_line_from args, :title
        __output_line_from args, :subtitle
        __output_line_from args, :author
        __output_line_from args, :date

        output "\\setbeamertemplate{navigation symbols}{}\n" if args[:disable_navigation]

        create_block :document, &block
    end
end
