(TeX-add-style-hook
 "tank-with-hole-no-variables"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "tikz" "border=5")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("siunitx" "detect-all")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "siunitx"))
 :latex)

