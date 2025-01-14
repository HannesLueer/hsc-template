.DEFAULT_GOAL := default

# Windows cmd clean commands
ifeq ($(OS),Windows_NT)
	SHELL := cmd.exe
	CLEAN_AUX = del /s *.aux
	CLEAN_IDX = del /s *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ist *.listing *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc

# Unix clean commands
else
	CLEAN_AUX +=-find . -name \*.aux -type f -delete
	CLEAN_IDX +=-rm -f *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs \
	    *.idx *.ilg *.ist *.listing *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc 2>/dev/null
endif

all:
	@-pdflatex --shell-escape Arbeit && makeglossaries Arbeit && \
	 makeindex Arbeit.nlo -s nomencl.ist -o Arbeit.nls && \
	 pdflatex --shell-escape Arbeit && biber Arbeit & \
	 pdflatex --shell-escape Arbeit && pdflatex --shell-escape Arbeit
	@$(CLEAN_AUX)

recompile_latex_dual: compile_latex compile_latex

compile_latex:
	@pdflatex --shell-escape Arbeit

default: recompile_latex_dual clean	

.PHONY: clean
clean:
	@$(CLEAN_AUX)
	@$(CLEAN_IDX)

full: all clean