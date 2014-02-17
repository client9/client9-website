
all: push

local:
	jekyll serve
build:
	jekyll build

push:
	jekyll build
	(cd _site; s3cmd sync . s3://www.client9.com)

clean:
	rm -rf _site

.PHONY: push build server clean
