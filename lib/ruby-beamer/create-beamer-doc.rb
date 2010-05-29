def beamer_document(args = {}, &block)
    theme = args[:theme] || "default"

    print "\\documentclass{beamer}\n"
    print "\\usetheme{#{theme}}\n"

    print "\\setbeamertemplate{navigation symbols}{}\n" if args[:disable_navigation]

    create_block :document, &block
end
