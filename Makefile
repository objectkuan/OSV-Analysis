gnuplot_scripts = $(wildcard ../data/*.gp)
gnuplot_images = $(gnuplot_scripts:../data/%.gp=fig/%.pdf)

all: $(gnuplot_images)
	pdflatex osv-report.tex

test: $(gnuplot_images)

$(gnuplot_images): fig/%.pdf: ../data/%.gp
	cd ../data && gnuplot $< && cd - && mv ../data/$(@:fig/%=%) $@

diff:
	latexdiff-git HEAD^ main.tex abstract.tex introdction.tex background.tex design.tex implementation.tex evaluation.tex related.tex conclusion.tex

wdiff:
	latexdiff-git  main.tex abstract.tex introdction.tex background.tex design.tex implementation.tex evaluation.tex related.tex conclusion.tex

clean:
	rm *.nav *.snm *.vim *.toc *.pdf *.aux *.bbl *.blg *.log *.out *.dvi *.fls *.fdb_latexmk *.gz *~ >/dev/null 2>&1

watch:
	latexmk -pdf -pvc main.tex
