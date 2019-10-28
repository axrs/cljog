#!/usr/bin/env bats

@test "can run scripts that include dependencies" {
	run ./cljog example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "Hello! from the other side" ]]
	[[ "${lines[1]}" == "Script: example-scripts/echo.clj" ]]
	[[ "${lines[2]}" == "Current working dir: /Users/xander/Projects/cljog" ]]
	[[ "${lines[3]}" == "Clojure version: {:major 1,"* ]]
	[[ "${lines[4]}" == "cljog version: 0.2.0" ]]
	[[ "${lines[5]}" == "Command line args: [first-arg second-arg third arg is a string]" ]]
	[[ "${lines[6]}" == "Random string:"* ]]
}

@test "scripts that throw uncaught exceptions have a non-zero exit code" {
	run ./cljog example-scripts exception.clj
	[[ "$status" -eq 1 ]]
}
