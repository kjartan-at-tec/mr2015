(TeX-add-style-hook
 "sensor-circuit"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "circuitikz")
   (TeX-add-symbols
    '("coil" 1)))
 :latex)

