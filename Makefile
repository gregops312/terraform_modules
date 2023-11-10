SHELL := /usr/bin/env bash
default: docs-update fmt validate

.PHONY: clean
clean:
	@find aws -type f -name '*.tf' -print0 | xargs -0 -n 1 dirname | sort -u | xargs -n1 -P 5 -I % rm -rf %/.terraform %/.terraform.lock.hcl

.PHONY: docs-check
docs-check:
	./bin/docs-check

.PHONY: docs-update
docs-update:
	@echo "##" ;\
	echo "## Docs Update" ;\
	echo "##" ;\
	./bin/docs-update

.PHONY: fmt
fmt:
	@echo "##" ;\
	echo "## Format" ;\
	echo "##" ;\
	terraform fmt -recursive ./

.PHONY: lint
lint:
	terraform fmt -check -recursive ./

.PHONY: validate
validate:
	@echo "##" ;\
	echo "## Validate" ;\
	echo "##" ;\
	if [[ ! -z "${CI}" ]]; then \
		export DIRS=$$(find aws -type f -name '*.tf' -print0 | xargs -0 -n 1 dirname | sort -u) ;\
	else \
		export DIRS=$$(comm -12 <(find aws -type f -name '*.tf' -print0 | xargs -0 -n 1 dirname | sort -u) <(git diff-index --name-only HEAD -- | gxargs -d '\n' -n 1 dirname | sort -u)) ;\
	fi ;\
	for i in $${DIRS}; do \
		echo "$${i}" ;\
		terraform -chdir="$${i}" init > /dev/null ;\
		terraform -chdir="$${i}" validate ;\
	done
