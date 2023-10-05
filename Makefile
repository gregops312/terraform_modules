default: fmt docs-update

.PHONY: docs-check
docs-check:
	./bin/docs-check

.PHONY: docs-update
docs-update:
	./bin/docs-update

.PHONY: fmt
fmt:
	terraform fmt -recursive ./

.PHONY: lint
lint:
	terraform fmt -check -recursive ./
