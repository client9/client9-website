
all: push

build:

push:
	jekyll
	(cd _site; s3cmd sync . s3://www.client9.com)
.PHONY: push build server
