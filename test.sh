#!/usr/bin/env bash
export PATH="$(pwd):$PATH"
./example-scripts/exception.clj
bats tests/scripts.bats
