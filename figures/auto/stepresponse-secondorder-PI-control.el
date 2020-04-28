(TeX-add-style-hook
 "stepresponse-secondorder-PI-control"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "tikz")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "ifthen"
    "pgf"
    "pgfplots"))
 :latex)

