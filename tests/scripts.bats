#!/usr/bin/env bats
load util

@test "scripts that throw uncaught exceptions have a non-zero exit code" {
	run example-scripts/exception.clj
	[[ "$status" -eq 1 ]]
}

@test "scripts that throw uncaught exceptions have a non-zero exit code invoked by cljog" {
	run ./cljog example-scripts/exception.clj
	[[ "$status" -eq 1 ]]
}

@test "can run scripts that include dependencies" {
	run example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	array_contains 'Hello! from the other side' "${lines[@]}"
	array_contains 'Script: example-scripts/echo.clj' "${lines[@]}"
	array_contains "Script dir: $(pwd)/example-scripts" "${lines[@]}"
	array_contains "Current working dir: $(pwd)" "${lines[@]}"
	array_contains 'cljog version: 1.2.0' "${lines[@]}"
	array_contains 'Command line args: [first-arg second-arg third arg is a string]' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

@test "can run scripts that include dependencies invoked from cljog" {
	run ./cljog example-scripts/echo.clj first-arg second-arg "third arg is a string"
	[[ "$status" -eq 0 ]]
	array_contains 'Hello! from the other side' "${lines[@]}"
	array_contains 'Script: example-scripts/echo.clj' "${lines[@]}"
	array_contains "Script dir: $(pwd)/example-scripts" "${lines[@]}"
	array_contains "Current working dir: $(pwd)" "${lines[@]}"
	array_contains 'cljog version: 1.2.0' "${lines[@]}"
	array_contains 'Command line args: [first-arg second-arg third arg is a string]' "${lines[@]}"
	array_contains 'Random string:' "${lines[@]}"
}

@test "scripts with --deps load an additional 'deps.edn' file from the script directory" {
	if env_split_string_supported;then
		run example-scripts/deps.clj "Extra Arg"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with additional deps provided by deps.edn' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}

@test "scripts with --deps load an additional 'deps.edn' file from the script directory invoked by cljog" {
	run ./cljog example-scripts/deps.clj "Extra Arg"
	[[ "$status" -eq 0 ]]
	array_contains 'This script was run with additional deps provided by deps.edn' "${lines[@]}"
}

@test "scripts with --deps=deps_file.edn load then additional 'deps_file.edn' file from the script directory" {
	if env_split_string_supported;then
		run example-scripts/deps_file.clj "Extra Arg"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with additional deps provided by deps_file.edn' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}

@test "scripts with --deps=deps_file.edn load then additional 'deps_file.edn' file from the script directory invoked by cljog" {
	run ./cljog example-scripts/deps_file.clj "Extra Arg" "something" "Another Arg" "Last Arg"
	[[ "$status" -eq 0 ]]
	array_contains 'This script was run with additional deps provided by deps_file.edn' "${lines[@]}"
	array_contains 'Extra Arg' "${lines[@]}"
	array_contains 'Last Arg' "${lines[@]}"
}

@test "scripts with --deps=../deps_file.edn load then additional 'deps_file.edn' file from a relative directory" {
	if env_split_string_supported;then
		run example-scripts/nested/deps_file.clj "Extra Arg"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with additional deps provided by relative ../deps_file.edn' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}

@test "the deps command can load a dependency file during runtime" {
	if env_split_string_supported;then
		run example-scripts/runtime_deps_file.clj "Extra Arg"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with additional deps loaded at runtime' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}

@test "the deps command can load a dependency file during runtime invoked by cljog" {
	run ./cljog example-scripts/runtime_deps_file.clj "Extra Arg"
	[[ "$status" -eq 0 ]]
	array_contains 'This script was run with additional deps loaded at runtime' "${lines[@]}"
}

@test "the deps command can load a dependency file missing the :deps keyword" {
	if env_split_string_supported;then
		run example-scripts/deps_file_without_deps.clj "Extra Arg"
		[[ "$status" -eq 0 ]]
		array_contains 'This script was run with a deps file missing the :deps key' "${lines[@]}"
	else
		skip "env does not support --split-string"
	fi
}

@test "the deps command can load a dependency file missing the :deps keyword invoked by cljog" {
	run ./cljog example-scripts/deps_file_without_deps.clj "Extra Arg"
	[[ "$status" -eq 0 ]]
	array_contains 'This script was run with a deps file missing the :deps key' "${lines[@]}"
}
