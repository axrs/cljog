#!/usr/bin/env bats
source ./tests/util.sh

setup () {
	mvn -q dependency:purge-local-repository -DmanualInclude="io.axrs.cli:example"
}

install_example_cli () {
	cd example && lein install > /dev/null && cd ..
}

@test "invalid or missing clis exit with non-zero code" {
	run ./cljog example
	[[ "$status" -eq 1 ]]
	[[ "${lines[0]}" == "cljog: Unable to find cli 'example'. Run 'cljog --list' to see a list of all available commands" ]]
}

@test "list doesn't include clis not installed" {
	repository=$(./cljog --config-get repository)
	run ./cljog --list
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Local Commands in: $repository/repository" ]]
	run array_contains 'Example CLI' "${lines[@]}"
	[[ "$status" -eq 1 ]]
}

@test "list does include clis currently installed" {
	install_example_cli
	repository=$(./cljog --config-get repository)
	run ./cljog --list
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Local Commands in: $repository/repository" ]]
	run array_contains 'Example CLI' "${lines[@]}"
	[[ "$status" -eq 0 ]]
}

@test "locally installed cli can be invoked with forwarded args" {
	install_example_cli
	run ./cljog example first-arg second-arg "third arg is a string"
	echo "${lines[@]}"
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Hello! from the example lib" ]]
	[[ "${lines[1]}" == "Clojure version: {:major 1"* ]]
	[[ "${lines[2]}" == "Command line args: (first-arg second-arg third arg is a string)" ]]
	[[ "${lines[3]}" == "Args:  (first-arg second-arg third arg is a string)" ]]
	[[ "${lines[4]}" == "Random string:"* ]]
}

teardown() {
	mvn -q dependency:purge-local-repository -DmanualInclude="io.axrs.cli:example"
}
