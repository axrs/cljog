#!/usr/bin/env bats
load util

setup() {
	mvn -q org.apache.maven.plugins:maven-dependency-plugin:3.0.0:purge-local-repository -DmanualInclude="io.axrs.cli:example"
	discovery_namespaces_bak="$(./cljog --config-get discovery_namespaces)"
	run ./cljog --config-set discovery_namespaces io.axrs.cli
}

install_example_cli() {
	cd example && lein install > /dev/null && cd ..
}

@test "invalid or missing clis exit with non-zero code" {
	run ./cljog example
	[[ "$status" -eq 1 ]]
	array_contains "cljog: Unable to find cli 'example'. Run 'cljog --list' to see a list of all available commands" "${lines[@]}"
}

@test "list doesn't include clis not installed" {
	repository=$(./cljog --config-get repository)
	run ./cljog --list
	[[ "$status" -eq 0 ]]
	array_contains "Local Commands in: $repository/repository" "${lines[@]}"
	! array_contains 'Example CLI' "${lines[@]}"
}

@test "list does include clis currently installed" {
	install_example_cli
	repository=$(./cljog --config-get repository)

	run ./cljog --list
	[[ "$status" -eq 0 ]]

	array_contains "Local Commands in: $repository/repository" "${lines[@]}"
	array_contains 'Example CLI' "${lines[@]}"
}

@test "locally installed cli can be invoked with forwarded args" {
	install_example_cli
	run ./cljog example first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	array_contains 'Hello! from the example lib' "${lines[@]}"
	array_contains 'Command line args: (first-arg second-arg third arg is a string)' "${lines[@]}"
	array_contains 'Args:  (first-arg second-arg third arg is a string)' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

teardown() {
	run ./cljog --config-set discovery_namespaces "$discovery_namespaces_bak"
	mvn -q org.apache.maven.plugins:maven-dependency-plugin:3.0.0:purge-local-repository -DmanualInclude="io.axrs.cli:example"
}
