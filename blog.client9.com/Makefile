
all: push

local:
	jekyll serve

push:
	jekyll build
	(cd _site; s3cmd sync . s3://blog.client9.com)

.PHONY: push local server
