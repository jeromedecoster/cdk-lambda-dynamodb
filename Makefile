.SILENT:

help:
	{ grep --extended-regexp '^[a-zA-Z0-9._-]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) || true; } \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-18s\033[0m%s\n", $$1, $$2 }'

setup: # install
	./make.sh setup

stats: # project stats
	./make.sh stats

deploy: # deploy infra
	./make.sh deploy

curl-add: # add item
	./make.sh curl-add

curl-list: # list items
	./make.sh curl-list

destroy: # destroy all resources
	./make.sh destroy
