(TeX-add-style-hook
 "or-circuit"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "circuitikz"))
 :latex)

