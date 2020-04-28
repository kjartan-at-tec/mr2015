(TeX-add-style-hook
 "linearization-example"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "inputenc"
    "pgf"
    "tikz"
    "pgfplots"))
 :latex)

