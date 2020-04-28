(TeX-add-style-hook
 "or-circuit-compl"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "circuitikz"))
 :latex)

