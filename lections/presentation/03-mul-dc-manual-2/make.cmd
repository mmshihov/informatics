pushd ./fig
call compile.cmd
popd
pdflatex 03-mul-dc-manual.beamer.tex
bibtex 03-mul-dc-manual.beamer.tex
pdflatex 03-mul-dc-manual.beamer.tex
pdflatex 03-mul-dc-manual.beamer.tex
