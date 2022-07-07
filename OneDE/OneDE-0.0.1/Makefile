LISP=/usr/bin/sbcl

clisp_BUILDOPTS=-K base -on-error exit < ./make-image.lisp
sbcl_BUILDOPTS=--load ./make-image.lisp
ccl_BUILDOPTS=--load ./make-image.lisp
ecl_BUILDOPTS=-shell ./make-image.lisp
lw_BUILDOPTS=-build ./make-image.lisp

clisp_INFOOPTS=-K base -on-error exit -x "(load (compile-file \"load-onede.lisp\")) (load (compile-file \"manual.lisp\")) (onede::generate-manual) (ext:exit)"
sbcl_INFOOPTS=--eval "(progn (load \"load-onede.lisp\") (load \"manual.lisp\"))" --eval "(progn (onede::generate-manual) (sb-ext:quit))"
ccl_INFOOPTS=--eval "(load \"load-onede.lisp\")" --load manual.lisp --eval "(progn (onede::generate-manual) (quit))"
ecl_INFOOPTS=-eval "(progn (load \"load-onede.lisp\") (load \"manual.lisp\"))" -eval "(progn (onede::generate-manual) (ext:quit))"
lw_INFOOPTS=-eval "(progn (load \"load-onede.lisp\") (load \"manual.lisp\"))" -eval "(progn (onede::generate-manual) (lw:quit))"

datarootdir = ${prefix}/share
prefix=/usr/local
exec_prefix= ${prefix}
bindir=${exec_prefix}/bin
infodir=${datarootdir}/info

# You shouldn't have to edit past this

FILES=onede.asd $(shell grep -o ":file \".*\"" onede.asd | sed 's,:file ",,g' | sed 's,",.lisp,g' )

all: onede onede.info

travis: onede
onede.info: onede.texi
	makeinfo onede.texi

# FIXME: This rule is too hardcoded
onede.texi: onede.texi.in
	$(LISP) $(sbcl_INFOOPTS)

onede: $(FILES)
	$(LISP) $(sbcl_BUILDOPTS)

release:
	git tag -a -m "version 0.0.1" 0.0.1
	git archive --format=tar --prefix=onede-0.0.1/ HEAD > onede-0.0.1.tar
	tar xf onede-0.0.1.tar
	cd onede-0.0.1 && tar zxf @PPCRE_PATH@/../cl-ppcre.tar.gz && mv cl-ppcre-* cl-ppcre
	git log > onede-0.0.1/ChangeLog
	cp configure onede-0.0.1/
	tar zcf onede-0.0.1.tgz onede-0.0.1
	rm -fr onede-0.0.1/ onede-0.0.1.tar

upload-release:
	gpg -b onede-0.0.1.tgz
	scp onede-0.0.1.tgz onede-0.0.1.tgz.sig sabetts@dl.sv.nongnu.org:/releases/onede/
	( echo rm onede-latest.tgz.sig && echo rm onede-latest.tgz && echo ln onede-0.0.1.tgz onede-latest.tgz && echo ln onede-0.0.1.tgz.sig onede-latest.tgz.sig ) | sftp -b - sabetts@dl.sv.nongnu.org:/releases/onede/

clean:
	rm -f *.fasl *.fas *.lib *.*fsl
	rm -f *.log *.fns *.fn *.aux *.cp *.ky *.log *.toc *.pg *.tp *.vr *.vrs
	rm -f onede onede.texi onede.info

install: onede.info onede
	test -z "$(destdir)$(bindir)" || mkdir -p "$(destdir)$(bindir)"
	install -m 755 onede "$(destdir)$(bindir)"
	test -z "$(destdir)$(infodir)" || mkdir -p "$(destdir)$(infodir)"
	install -m 644 onede.info "$(destdir)$(infodir)"
	install-info --info-dir="$(destdir)$(infodir)" "$(destdir)$(infodir)/onede.info"
install-modules:
	git clone https://github.com/onede/onede-contrib.git ~/.onede.d/modules
uninstall:
	rm "$(destdir)$(bindir)/onede"
	install-info --info-dir="$(destdir)$(infodir)" --remove "$(destdir)$(infodir)/onede.info"
	rm "$(destdir)$(infodir)/onede.info"

# End of file
