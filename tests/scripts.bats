#!/usr/bin/env bats
load util

@test "can run scripts that include dependencies" {
	run example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]

	array_contains 'Hello! from the other side' "${lines[@]}"
	array_contains 'Script: example-scripts/echo.clj' "${lines[@]}"
	array_contains "Script dir: $(pwd)/example-scripts" "${lines[@]}"
	array_contains "Current working dir: $(pwd)" "${lines[@]}"
	array_contains 'cljog version: 0.4.1' "${lines[@]}"
	array_contains 'Clojure version: {:major 1,' "${lines[@]}"
	array_contains 'Command line args: [first-arg second-arg third arg is a string]' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

@test "scripts that throw uncaught exceptions have a non-zero exit code" {
	run example-scripts/exception.clj
	[[ "$status" -eq 1 ]]
}

@test "scripts with --launch-deps have dependencies available" {
	run example-scripts/launch_deps.clj "Extra Arg"
	[[ "$status" -eq 0 ]]

	array_contains 'Running example-scripts/launch_deps.clj with extra dependencies:' "${lines[@]}"
	array_contains 'io.jesi/backpack {:mvn/version "4.2.1"}' "${lines[@]}"
	array_contains 'Extra Arg' "${lines[@]}"
}
