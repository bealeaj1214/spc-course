TEXBIN=/usr/texbin

PATH:=${TEXBIN}:${PATH}

BASE_DIR=.

TEXINPUTS:=.:${BASE_DIR}/tex:

export TEXINPUTS

PDFLATEX:=${TEXBIN}/xelatex

export PDFLATEX


generated ::
	@test -d $@ || mkdir -p $@

tex ::
	@test -d $@ || mkdir -p $@

tik ::
	@test -d $@ || mkdir -p $@

%.pdf :: %.tex  generated 
	texi2dvi -b -p --tidy --build-dir=generated -V $<


%.tex :: %.Rnw tex tik
	R CMD Sweave $<


tik/%.pdf :: tik/%.tex
	cd tik ; echo pdflatex $<

TIK_TEX_FILES := $(shell ls tik/*.tex)


TIK_PDF_FILES :=$(TIK_TEX_FILES:%.tex=%.pdf)


debug::
	echo $(TIK_PDF_FILES)


