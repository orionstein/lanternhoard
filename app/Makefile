.PHONY: all test clean

all: run

buildelm:
	$(MAKE) -C elm/storewatch all


buildapp: buildelm
	rm -rf dist/;
	gulp;

build: buildapp

deploy: build
	$(MAKE) -C dist/ deploy

run: build
	cd dist; python -m http.server;
