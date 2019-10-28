#!/usr/bin/env bats

setup () {
	./cljog --config-set print-key find-this-in-catted-config
	./cljog --config-set test-key
}

@test "can print the current config, including file location" {
	run ./cljog --config
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "cljog: $HOME/.cljog" ]]
	[[ " ${lines[@]} " =~ " print-key=find-this-in-catted-config " ]]

	run ./cljog --config-set print-key
	run ./cljog --config
	[[ "$status" -eq 0 ]]
	[[ ! " ${lines[@]} " =~ " print-key=find-this-in-catted-config " ]]
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
	[[ "${lines[0]}" == "a-new-value" ]]

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
