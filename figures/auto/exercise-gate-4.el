(TeX-add-style-hook
 "exercise-gate-4"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("circuitikz" "american")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "inputenc"
    "circuitikz"))
 :latex)

