SHELL := /usr/bin/zsh # you must run this Makefile using the zsh interpreter
filename=main

# The reason why the command expansion $(command) is not working in your Makefile is because it is not being evaluated by the shell, but by Make itself. In Make, the $ character has a special meaning and is used to reference variables, so when you write $(command) in your Makefile, Make thinks you are trying to reference a variable called command and not running the command command. double dollar sign ($$) forces shell to run this command, $(shell command) also works

# By default, the shell interpreter used by a Makefile is /bin/sh. However, you can change the shell interpreter that must run the Makefile by setting the SHELL variable at the beginning of the Makefile. When you use := to define a variable with a shell command, like MY_VAR := $(shell date), the command is evaluated immediately and the result is stored as a simple string. The value of the variable is not re-evaluated every time it is used in a command. That is, it is evaluated only once.

# the "-" operator to ignore the exit status of the command and let the rule. When you have a conditional statement without an else and it return false (1 or more), it is not handled by the shell and is returned to the Makefile, which in turn stop the procedure. the "-" at the beginning of the command make Makefile ignore it

all: compile
	
compile: | default_preamble.tex # check whether it exists but does not trigger it (if don't exist, however, it is triggered)
	@echo "Compiling..."
	@-[[ -f main.tex ]] && [[ ! $$(cat main.tex) =~ '\\input\{default_preamble(\.tex)?\}' ]] && sed -i '2i\\\input{default_preamble.tex}' main.tex
	lualatex --shell-escape -synctex=1 -interaction=nonstopmode -file-line-error $(filename).tex
	@echo "Process completed successfully!"

default_preamble.tex:
	@echo "Downloading the default preamble"
	wget -qO $@ https://gist.githubusercontent.com/tapyu/886dc95fc19c4250fb38581ccc58bed8/raw/a7839f43cb09d8716b783bc937196cd1a952fd1b/_default_preamble.tex # The macro @ evaluates to the name of the current target
	
clean:
	@echo -n "cleaning auxiliary files...\n"
	@rm -f *.out *.aux *.alg *.acr *.dvi *.gls *.log *.bbl *.blg *.ntn *.not *.lof *.lot *.toc *.loa *.lsg *.nlo *.nls *.ilg *.ind *.ist *.glg *.glo *.xdy *.acn *.idx *.loq *~
	@rm -f $(filename).pdf
	@echo "Process completed successfully!"