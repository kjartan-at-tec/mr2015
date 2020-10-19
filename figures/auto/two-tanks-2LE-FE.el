(TeX-add-style-hook
 "two-tanks-2LE-FE"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "inputenc"
    "fontenc"
    "graphicx"
    "amsmath"
    "pgf"
    "tikz"
    "circuitikz")
   (TeX-add-symbols
    "valve"))
 :latex)

