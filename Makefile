.PHONY: install all

all: apricot_v20.8-compatible.tar.gz

apricot_v20.8-compatible.tar.gz: docker/*
	# docker build -t linuxdeepin/apricot:v20.8-compatible ./docker
	docker save -o apricot_v20.8-compatible.tar linuxdeepin/apricot:v20.8-compatible
	gzip -9 apricot_v20.8-compatible.tar

install: all demo/*
	install -d ${DESTDIR}/usr/bin/
	install demo/* ${DESTDIR}/usr/bin/
	install -d ${DESTDIR}/usr/share/deepin/compatibility-mode/
	install apricot_v20.8-compatible.tar.gz ${DESTDIR}/usr/share/deepin/compatibility-mode/
