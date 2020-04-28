(TeX-add-style-hook
 "adjacency-circuit-2"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "circuitikz"))
 :latex)

