#!/usr/bin/env bats

array_contains () {
	local seeking=$1; shift
	local in=1
	for element; do
			if [[ ${element} == *"$seeking"* ]]; then
					in=0
					break
			fi
	done
	return $in
}

assert_help () {
	[[ "$status" -eq 0 ]]

	[[ " ${lines[@]} " =~ " command discovery " ]]

	result="$(array_contains 'cljog --list' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	result="$(array_contains 'cljog --update' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	result="$(array_contains 'cljog cmd [arg1] [arg2] [arg3]' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	[[ " ${lines[@]} " =~ " config " ]]
	result="$(array_contains 'cljog --config' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	result="$(array_contains 'cljog --config-set key [value]' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	result="$(array_contains 'cljog --config-get key' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]

	[[ " ${lines[@]} " =~ " miscellaneous " ]]
	result="$(array_contains 'cljog --version' "${lines[@]}" )"
	[[ "$result" -eq 0 ]]
}

@test "prints the current version" {
	run ./cljog --version
	[[ "$status" -eq 0 ]]
	[[ "${lines[0]}" == "0.2.0" ]]
}

@test "prints help if given no args" {
	run ./cljog
	assert_help
}

@test "prints help if given --help" {
	run ./cljog --help
	assert_help
}
