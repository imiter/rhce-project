#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause

set -euo pipefail

# Run script ensure_provider_tests.py and append test files generated by it to the commit.

# This script is intended to be used as git post-commit hook.
# Make sure file is executable and copy it to <your repo>/.git/hooks/post-commit
# This script has to be used together with pre-commit to work properly.

GITPATH=$(git rev-parse --show-toplevel)

if [ -e "$GITPATH/.commit" ]; then
    rm "$GITPATH/.commit"

    cd "$GITPATH/tests"
    python ./ensure_provider_tests.py generate
    cd "$GITPATH"
    git add tests/tests_*_nm.yml tests/tests_*_initscripts.yml
    git commit --amend -C HEAD --no-verify
fi
