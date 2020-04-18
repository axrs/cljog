#!/usr/bin/env bats
load util

setup () {
	./cljog --config-set print-key find-this-in-catted-config
	./cljog --config-set test-key
}

@test "can print the current config, including file location" {
	run ./cljog --config
	[[ "$status" -eq 0 ]]

	array_contains "cljog: $HOME/.cljog" "${lines[@]}"
	array_contains 'print-key=find-this-in-catted-config' "${lines[@]}"

	run ./cljog --config-set print-key
	[[ "$status" -eq 0 ]]

	run ./cljog --config
	[[ "$status" -eq 0 ]]

	! array_contains 'print-key=find-this-in-catted-config' "${lines[@]}"
}

@test "can get, set and clear a config option" {
	run ./cljog --config-get test-key
	[[ "$status" -eq 0 ]]
	[[ -z "$lines" ]]

	run ./cljog --config-set test-key a-new-value
	[[ "$status" -eq 0 ]]
	[[ -z "$lines" ]]

	run cljog --config-get test-key
	[[ "$status" -eq 0 ]]
	array_contains 'a-new-value' "${lines[@]}"

	run cljog --config-set test-key
	[[ "$status" -eq 0 ]]
	[[ -z "$lines" ]]

	run cljog --config-get test-key
	[[ "$status" -eq 0 ]]
	[[ -z "$result" ]]
}

teardown() {
	./cljog --config-set test-key
	./cljog --config-set print-key
}
