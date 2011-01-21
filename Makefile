TEXBIN=/usr/texbin

PATH:=${TEXBIN}:${PATH}

BASE_DIR=.

TEXINPUTS:=.:${BASE_DIR}/tex:

export TEXINPUTS

PDFLATEX:=${TEXBIN}/xelatex

export PDFLATEX


generated ::
	@test -d $@ || mkdir -p $@

%.pdf :: %.tex  generated
	texi2dvi -b -p --tidy --build-dir=generated -V $<


%.tex :: %.Rnw
	R CMD Sweave $<

