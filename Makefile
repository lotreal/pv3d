.PHONY:debug

debug:
	bin/build.sh

TAGS:
	find -L . -name "*.as" | ctags -e -L -
tag:TAGS