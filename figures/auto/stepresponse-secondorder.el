(TeX-add-style-hook
 "stepresponse-secondorder"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "tikz")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "pgf"
    "pgfplots"))
 :latex)

