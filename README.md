# CircleCI Packaging a config

This is an example project to show how to package a config.

## Prerequisites

* Docker - needed for the executors
* [CircleCI CLI](https://circleci.com/docs/local-cli/)
* make - on a *nix system run `sudo apt install make`

## Running Locally

I've included a `Makefile` to simplify the commands, if you run `make all` this will,

* package the configuration
* process the configuration (required for version 2.1 and greater)
* run the `lint-and-test` job (unfortunately the cli does not support running workflows at this time)

## Modifying the workflow

If you want to modify the workflow try editing `.circleci/src/commands/test.yml` and change the `echo` command to,

```
description: "Test code"
steps:
  - run:
      name: test
      command: |
        echo Running test coverage.
```

Save the file and you will need to run the `circleci config pack` command to updated the `.circleci/config.yml` file, you can run `make package-config` and view the comparions with git.  Next, you can run `make all` and view the output from the cli.