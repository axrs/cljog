#!/usr/bin/env bats
load util

@test "can run scripts that include dependencies with --bb in the shebang" {
	run example-scripts/echo_bb.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	array_contains 'Hello! from the other side' "${lines[@]}"
	array_contains 'Script: example-scripts/echo_bb.clj' "${lines[@]}"
	array_contains "Script dir: $(pwd)/example-scripts" "${lines[@]}"
	array_contains "Current working dir: $(pwd)" "${lines[@]}"
	array_contains 'cljog version: 1.3.0' "${lines[@]}"
	array_contains 'Command line args: [first-arg second-arg third arg is a string]' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

@test "can run scripts that include dependencies invoked from cljog with --bb shebang" {
	run ./cljog example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	array_contains 'Hello! from the other side' "${lines[@]}"
	array_contains 'Script: example-scripts/echo.clj' "${lines[@]}"
	array_contains "Script dir: $(pwd)/example-scripts" "${lines[@]}"
	array_contains "Current working dir: $(pwd)" "${lines[@]}"
	array_contains 'cljog version: 1.3.0' "${lines[@]}"
	array_contains 'Command line args: [first-arg second-arg third arg is a string]' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

@test "scripts with --deps=deps_file.edn load then additional 'deps_file.edn' file from the script directory invoked by cljog with --bb" {
	run ./cljog example-scripts/deps_file_bb.clj "Extra Arg" "something" "Another Arg" "Last Arg"
	[[ "$status" -eq 0 ]]
	array_contains 'This script was run with additional deps provided by deps_file.edn' "${lines[@]}"
	array_contains 'Extra Arg' "${lines[@]}"
	array_contains 'Last Arg' "${lines[@]}"
}

@test "scripts with --deps=../deps_file.edn load then additional 'deps_file.edn' file from a relative directory with --bb" {
	if env_split_string_supported;then
		run example-scripts/nested/deps_file_bb.clj "Extra Arg"
		echo "$lines"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with additional deps provided by relative ../deps_file.edn' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}
