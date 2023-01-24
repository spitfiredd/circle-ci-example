SHELL:=/bin/bash
JOB_NAME=lint-and-test
.DEFAULT_GOAL := help

.PHONY: help
# Put it first so that "make" without argument is like "make help".
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-32s-\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


# circle-config: SHELL:=/bin/bash
# circle-config:
.PHONY: package-config
package-config:  ## Package circleci config and validate the file
	circleci -h >/dev/null 2>&1 || { echo >&2 "Install the circleci cli"; }
	cd .circleci && circleci config pack src > config.yml
	circleci config validate

.PHONY: process-config
process-config:  ## Process config file
	circleci config process .circleci/config.yml > process.yml
	
.PHONY: run-job
run-job:  ## Run job
	circleci local execute -c process.yml "${JOB_NAME}"

.PHONY: all
all:  package-config process-config run-job  ## Run all commands
