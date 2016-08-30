.PHONY: all test clean

all: run

buildelm:
	$(MAKE) -C elm/storewatch all

buildapp: buildelm
	rm -rf dist/;
	gulp;

buildrelease: buildelm
	rm -rf dist/;
	gulp release;

build: buildapp

deploy: buildrelease
	$(MAKE) -C dist/ deploy

run: build
	cd dist; python -m http.server;

runrelease: buildrelease
	cd dist; python -m http.server;
