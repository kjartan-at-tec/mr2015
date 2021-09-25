(TeX-add-style-hook
 "RC-step-response-design"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("SIunits" "amssymb")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "fontenc"
    "inputenc"
    "pgf"
    "tikz"
    "pgfplots"
    "SIunits")
   (TeX-add-symbols
    "Gain"))
 :latex)

