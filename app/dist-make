.PHONY: all test clean

all: run

deploy:
	aws s3 sync . s3://www.lanternhoard.com
	aws cloudfront create-invalidation --distribution-id "E1LGYATKKQCO1R" --paths "/*"

run:
	python -m http.server;
