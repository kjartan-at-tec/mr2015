(TeX-add-style-hook
 "cylinder"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "tikz" "border=5")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("siunitx" "detect-all")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "siunitx")
   (TeX-add-symbols
    "pp"))
 :latex)

