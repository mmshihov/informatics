pushd ./fig
call compile.cmd
popd
pdflatex 01-mul-base-pc.beamer.tex
bibtex 01-mul-base-pc.beamer.tex
pdflatex 01-mul-base-pc.beamer.tex
pdflatex 01-mul-base-pc.beamer.tex
