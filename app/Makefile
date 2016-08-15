.PHONY: all test clean

all: run

buildelm:
	$(MAKE) -C elm/storewatch all

buildapp: buildelm
	rm -rf dist/;
	gulp;

build: buildapp

run: build
	cd dist; python -m http.server;
