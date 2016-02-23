# Makefile
TEXFILES = $(wildcard *.tex)
PDFFILES = $(TEXFILES:.tex=.pdf)


all: pdflatex clean

pdf: $(PDFFILES)

%.pdf: %.tex
	@rubber --pdf $<
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

pdflatex: $(TEXFILES)
	@pdflatex $(TEXFILES:.tex=)
	#@TEXMFOUTPUT=`pwd` bibtex `pwd`/$(TEXFILES:.tex=)
	#@pdflatex $(TEXFILES:.tex=)
	@pdflatex $(TEXFILES:.tex=)
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

clean:
	#@rubber --clean $(TEXFILES:.tex=)
	rm -rf *.aux  *.log  *.out  *.toc

distclean: clean
	#@rubber --clean --pdf $(TEXFILES:.tex=)
	@rm -rf publish
	@rm -f $(PDFFILES)

preview:
	@open -a preview publish/$(PDFFILES) &> /dev/null &

evince:
	@evince publish/$(PDFFILES) &> /dev/null &
