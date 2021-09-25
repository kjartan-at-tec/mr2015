(TeX-add-style-hook
 "pneumatics"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "presentation" "aspectratio=1610")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("circuitikz" "american" "siunitx")))
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref"
    "khpreamble"
    "pgfplots"
    "pdfpages"
    "circuitikz")
   (LaTeX-add-labels
    "sec:org51761b9"
    "sec:org204bbc8"
    "sec:org1e2592c"))
 :latex)

