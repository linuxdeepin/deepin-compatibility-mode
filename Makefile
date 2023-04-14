.PHONY: install all deb

all: apricot_v20.8-compatible.tar.gz

apricot_v20.8-compatible.tar.gz: docker/*
	# NOTE(black_desk): uncomment the line below to let docker build the
	# image locally, if you do not have the image downloaded yet:
	# docker build -t linuxdeepin/apricot:v20.8-compatible ./docker
	docker save -o apricot_v20.8-compatible.tar linuxdeepin/apricot:v20.8-compatible
	gzip -9 apricot_v20.8-compatible.tar

install: all demo/*
	install -d ${DESTDIR}/usr/bin/
	install demo/* ${DESTDIR}/usr/bin/
	install -d ${DESTDIR}/usr/share/deepin/compatibility-mode/
	install apricot_v20.8-compatible.tar.gz ${DESTDIR}/usr/share/deepin/compatibility-mode/

deb: deepin-compatibility-mode.deb

deepin-compatibility-mode.deb: debian/*
	mkdir -p tmp/deepin-compatibility-mode
	install -d tmp/deepin-compatibility-mode/DEBIAN
	install debian/* tmp/deepin-compatibility-mode/DEBIAN
	DESTDIR=tmp/deepin-compatibility-mode make install
	dpkg-deb --build tmp/deepin-compatibility-mode
	mv tmp/deepin-compatibility-mode.deb .
