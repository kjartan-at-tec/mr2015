(TeX-add-style-hook
 "separation-work-items-state-transition"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "tikz"
    "pgfplots"))
 :latex)

