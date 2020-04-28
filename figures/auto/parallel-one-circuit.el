(TeX-add-style-hook
 "parallel-one-circuit"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "circuitikz"))
 :latex)

