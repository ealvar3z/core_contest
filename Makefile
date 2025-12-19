ORG=core_contest.org
EMACS=emacs

all: slides html pdf

slides:
	$(EMACS) -Q --batch \
	  -l ox-reveal \
	  $(ORG) \
	  -f org-reveal-export-to-html

html:
	$(EMACS) -Q --batch \
	  $(ORG) \
	  -f org-html-export-to-html

pdf:
	$(EMACS) -Q --batch \
	  $(ORG) \
	  -f org-latex-export-to-pdf

clean:
	rm -f *.html *.pdf
