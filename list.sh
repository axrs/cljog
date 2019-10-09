#!/usr/bin/env bash
repo_dir=$(realpath ~/.m2/repository)
repo_dir_str_length=$((${#repo_dir} + 1))
artifacts=$(find "$repo_dir/io/axrs" "$repo_dir/io/jesi" -name *.jar)

declare -A clis

for artifact in $artifacts; do
	artifact="${artifact:$repo_dir_str_length}"
	groupId=$(echo "$artifact" | rev | cut -d/ -f4- | rev | tr / .)
	artifactId=$(echo "$artifact" | awk -F/ '{print $(NF-2)}')
	version=$(echo "$artifact" | awk -F/ '{print $(NF-1)}')
	cli="$groupId/$artifactId"
	knownVersion=${clis["$cli"]}
	if [[ $version > $knownVersion ]];then
		clis["$cli"]="$version"
	fi
done

echo "Local Commands"
for dep in "${!clis[@]}"
do
	artifact=$(echo "$dep" | awk -F/ '{print $NF}')
	version="${clis[$dep]}"
	pom="$repo_dir/$(echo "$dep" | tr . /)/$version/*$version.pom" 
	pom=$(realpath $pom)
	groupId=$(echo $dep | cut -d/ -f1)
	if test -f "$pom"; then
		echo -e "    $artifact\t$groupId\t$version\t$(cat "$pom" | grep -oPm1 "(?<=<description>)[^<]+")"
	fi
done | column -ts $'\t' | sort | cut -b -$(tput cols)
