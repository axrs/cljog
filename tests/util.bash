array_contains() {
	local seeking
	seeking="$1";
	shift
	local element
	for element;do
		[[ "$element" == *"$seeking"* ]] && return 0
	    echo "'$seeking' was not found in '$element'" 1>&2
	done
	return 1
}

env_split_string_supported() {
	$(echo "exit" | env --split-string bash 2> /dev/null)
	[[ "$?" -eq 0 ]]
}
