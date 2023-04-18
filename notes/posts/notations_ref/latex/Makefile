filename=main

all: compile
	
compile: | default_preamble.tex # it must exist but it didn't must rebuilt to build compile (if don't exist, however, build it first)
	@echo "Compiling..."
	lualatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error $(filename).tex
	@echo "Process completed successfully!"

default_preamble.tex:
	@echo "Downloading the default preamble"
	wget -qO default_preamble.tex https://gist.githubusercontent.com/tapyu/886dc95fc19c4250fb38581ccc58bed8/raw/a7839f43cb09d8716b783bc937196cd1a952fd1b/_default_preamble.tex
	
clean:
	@echo -n "cleaning auxiliary files...\n"
	@rm -f *.out *.aux *.alg *.acr *.dvi *.gls *.log *.bbl *.blg *.ntn *.not *.lof *.lot *.toc *.loa *.lsg *.nlo *.nls *.ilg *.ind *.ist *.glg *.glo *.xdy *.acn *.idx *.loq *~
	@rm -f $(filename).pdf
	@echo "Process completed successfully!"