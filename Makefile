export

SHELL := /bin/bash -o errexit -o nounset -o pipefail

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

VERBOSE ?= false
ifeq (${VERBOSE}, false)
	MAKEFLAGS += --silent
endif

# Variables
EXAMPLE_DIR      := example
HUGO_BASEURL    ?= http://localhost:1313/
HUGO_CACHEDIR   ?= ${CURDIR}/.hugo_cache
# Hugo Extended 0.162.0 or newer is required.
HUGO_MIN_VERSION := 0.162.0

# Applications
GIT  ?= git
GO   ?= go
HUGO ?= hugo
MAKE ?= make

# Helpers
.PHONY: depend
depend: ## Verify required local tooling
	hugo_version="$$( $(HUGO) version )"; \
	echo "$${hugo_version}"; \
	$(GO) version; \
	$(GIT) --version; \
	$(MAKE) --version | head -n 1; \
	if [[ "$${hugo_version}" != *extended* ]]; then \
		echo "Hugo Extended ${HUGO_MIN_VERSION}+ is required." >&2; \
		exit 1; \
	fi; \
	version="$$(sed -E 's/^hugo v([0-9]+\.[0-9]+\.[0-9]+).*/\1/' <<< "$${hugo_version}")"; \
	IFS=. read -r major minor patch <<< "$${version}"; \
	IFS=. read -r min_major min_minor min_patch <<< "${HUGO_MIN_VERSION}"; \
	if (( major < min_major || (major == min_major && minor < min_minor) || (major == min_major && minor == min_minor && patch < min_patch) )); then \
		echo "Hugo Extended ${HUGO_MIN_VERSION}+ is required; found $${version}." >&2; \
		exit 1; \
	fi

.PHONY: run
run: ## Serve the example site locally
	cd ${EXAMPLE_DIR} && $(HUGO) server --baseURL ${HUGO_BASEURL} --cacheDir ${HUGO_CACHEDIR} --disableFastRender

# Testing
.PHONY: test
test: ## Run a strict Hugo build for the example site
	cd ${EXAMPLE_DIR} && $(HUGO) --gc --minify --printPathWarnings --printUnusedTemplates --cacheDir ${HUGO_CACHEDIR}

# Building
.PHONY: build
build: ## Build production output for the example site
	cd ${EXAMPLE_DIR} && $(HUGO) --gc --minify --baseURL ${HUGO_BASEURL} --cacheDir ${HUGO_CACHEDIR}

# Cleaning
.PHONY: clean
clean: ## Remove generated Hugo output and caches
	rm -rf ${EXAMPLE_DIR}/public ${EXAMPLE_DIR}/resources ${EXAMPLE_DIR}/.hugo_cache resources ${HUGO_CACHEDIR} .hugo_build.lock ${EXAMPLE_DIR}/.hugo_build.lock

# Make Helpers
.PHONY: help
help: ## Print this help message
	grep -E '^[/a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":|##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$3}'

print-%: ## Print the value of a variable
	echo $* = $($*)
