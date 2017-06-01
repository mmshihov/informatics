pushd .\fig
call make.cmd
popd
pdflatex main.book.tex
bibtex main.book
pdflatex main.book.tex
pdflatex main.book.tex
