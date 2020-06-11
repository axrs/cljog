#!/usr/bin/env bats
load util

assert_help() {
	array_contains 'command discovery' "${lines[@]}"
	array_contains 'cljog --list' "${lines[@]}"
	array_contains 'cljog --update' "${lines[@]}"
	array_contains 'cljog cmd [arg1] [arg2] [arg3]' "${lines[@]}"
	array_contains 'config' "${lines[@]}"
	array_contains 'cljog --config' "${lines[@]}"
	array_contains 'cljog --config-set key [value]' "${lines[@]}"
	array_contains 'cljog --config-get key' "${lines[@]}"
	array_contains 'miscellaneous' "${lines[@]}"
	array_contains 'cljog --version' "${lines[@]}"
}

@test "prints the current version" {
	run ./cljog --version
	[[ "$status" -eq 0 ]]

	array_contains '1.3.0' "${lines[@]}"
}

@test "prints help if given no args" {
	run ./cljog
	[[ "$status" -eq 0 ]]

	assert_help
}

@test "prints help if given --help" {
	run ./cljog --help
	[[ "$status" -eq 0 ]]

	assert_help
}
