(TeX-add-style-hook
 "AB-state-diagram-long-cycle"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("circuitikz" "american")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "amsmath"
    "inputenc"
    "circuitikz"))
 :latex)

