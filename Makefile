VERSION  := $(shell cat VERSION.txt)
FILENAME := target/cljmd-$(VERSION).tar.gz

install:
	cp cljmd /usr/local/bin/

clean:
	rm -rf target/
	mkdir target

build: clean
	tar --create --gzip --options gzip:compression-level=9 --file $(FILENAME) cljmd

TAG := v$(VERSION)

release: build
#TODO release notes (from CHANGELOG.md)
	git tag $(TAG) && git push --tags
#TODO create hub rlease issue (since it just does a HTTP 404)
#	hub release create -a $(FILENAME) -m $(TAG) $(TAG)

.PHONY: install -check-tag build release
