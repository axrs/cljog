#!/usr/bin/env bash
set -e
export PATH="$(pwd):$PATH"

echo 'Running config tests'
bats "tests/config.bats"

echo 'Running miscellaneous tests'
bats "tests/miscellaneous.bats"

echo 'Running cli tests using cljog'
bats "tests/clis.bats"

echo 'Running script tests using cljog'
bats "tests/scripts.bats"

echo 'Running script tests using babashaka'
export CLJOG_PREFER_BB=true
bats "tests/scripts.bats"
