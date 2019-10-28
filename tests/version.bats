#!/usr/bin/env bats

@test "prints the current version" {
  result="$(../cljog/cljog --version)"
  [[ "$result" == "0.2.0" ]]
}
