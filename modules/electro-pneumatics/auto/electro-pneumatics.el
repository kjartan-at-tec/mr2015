(TeX-add-style-hook
 "electro-pneumatics"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "presentation" "aspectratio=1610")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem")))
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
    "sec:org67c67af"
    "sec:org81ff278"
    "sec:org7d592ef"
    "sec:org21f48c3"
    "sec:orgc94041b"
    "sec:orga08f675"))
 :latex)

