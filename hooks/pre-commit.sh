#! /usr/bin/env bash

set -euxo pipefail

# Only reformat the Python files we're about to commit.
#
# If grep finds no .py files, it exits with error code 1, which aborts the
# script. So we force grep to return 0 (success) with `|| true`
git diff --staged --name-only | grep '\.py$' || true | xargs black

# Re-add the reformatted files to the commit
git diff --staged --name-only | xargs git add

# Run pytest with proper Python path
./run_tests.sh

