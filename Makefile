.PHONY: install all deb

all: apricot_v20.8-compatible.tar.gz

apricot_v20.8-compatible.tar.gz: docker/*
	docker pull linuxdeepin/apricot:v20.8-compatible
	docker save -o apricot_v20.8-compatible.tar linuxdeepin/apricot:v20.8-compatible
	gzip -9 apricot_v20.8-compatible.tar

install: all demo/*
	install -d ${DESTDIR}/usr/bin/
	install demo/* ${DESTDIR}/usr/bin/
	install -d ${DESTDIR}/usr/share/deepin/compatibility-mode/
	install apricot_v20.8-compatible.tar.gz ${DESTDIR}/usr/share/deepin/compatibility-mode/
	install -d ${DESTDIR}/usr/share/applications/
	install misc/deepin-v20.desktop ${DESTDIR}/usr/share/applications/
	install -d ${DESTDIR}/usr/share/icons/
	install misc/deepin-compatible-mode.svg ${DESTDIR}/usr/share/icons

deb: deepin-compatibility-mode.deb

deepin-compatibility-mode.deb: debian/*
	mkdir -p tmp/deepin-compatibility-mode
	install -d tmp/deepin-compatibility-mode/DEBIAN
	install debian/* tmp/deepin-compatibility-mode/DEBIAN
	DESTDIR=tmp/deepin-compatibility-mode make install
	dpkg-deb --build tmp/deepin-compatibility-mode
	mv tmp/deepin-compatibility-mode.deb .
