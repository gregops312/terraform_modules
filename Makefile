default: fmt

.PHONY: fmt
fmt:
	terraform fmt -recursive ./

.PHONY: lint
lint:
	terraform fmt -check -recursive ./
