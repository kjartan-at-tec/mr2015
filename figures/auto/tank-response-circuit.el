(TeX-add-style-hook
 "tank-response-circuit"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("circuitikz" "american")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "inputenc"
    "circuitikz"
    "graphicx")
   (TeX-add-symbols
    '("myscope" 2)))
 :latex)

