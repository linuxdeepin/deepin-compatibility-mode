.PHONY: install all

all: apricot_v20.8-compatible.tar.gz

apricot_v20.8-compatible.tar:
	docker build -t linuxdeepin/apricot:v20.8-compatible ./docker
	docker save -o apricot_v20.8-compatible.tar linuxdeepin/apricot:v20.8-compatible

apricot_v20.8-compatible.tar.gz: apricot_v20.8-compatible.tar
	gzip -9 apricot_v20.8-compatible.tar

install: all
	install -m 755 demo/* $DESTDIR/usr/bin/
	install -m 755 apricot_v20.8-compatible.tar.gz $DESTDIR/usr/share/deepin/compatibility-mode/
