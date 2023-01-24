circle-config: SHELL:=/bin/bash
circle-config:
	circleci -h >/dev/null 2>&1 || { echo >&2 "Install the circleci cli"; }
	cd .circleci && circleci config pack src > config.yml
	circleci config validate