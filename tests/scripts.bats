#!/usr/bin/env bats

@test "can run scripts that include dependencies" {
	run example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Hello! from the other side" ]]
	[[ "${lines[1]}" == "Script: example-scripts/echo.clj" ]]
	[[ "${lines[2]}" == "Current working dir: /Users/xander/Projects/cljog" ]]
	[[ "${lines[3]}" == "Clojure version: {:major 1,"* ]]
	[[ "${lines[4]}" == "cljog version: 0.3.1" ]]
	[[ "${lines[5]}" == "Command line args: [first-arg second-arg third arg is a string]" ]]
	[[ "${lines[6]}" == "Random string:"* ]]
}

@test "scripts that throw uncaught exceptions have a non-zero exit code" {
	run example-scripts/exception.clj
	[[ "$status" -eq 1 ]]
}

@test "scripts with --launch-deps have dependencies available" {
	run example-scripts/launch_deps.clj "Extra Arg"
	echo "${lines[1]}"
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Running example-scripts/launch_deps.clj with extra dependencies:"* ]]
	[[ "${lines[1]}" =~ ^\{?[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}\}?$ ]]
	[[ "${lines[2]}" == "Extra Arg" ]]
}
