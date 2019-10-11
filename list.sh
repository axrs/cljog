#!/usr/bin/env bash
config_file=$HOME/.cljash

sed_escape() {
	sed -e 's/[]\/$*.^[]/\\&/g'
}

cfg_write() { # key, value
	cfg_delete "$config_file" "$1"
	echo "$1=$2" >> "$config_file"
}

cfg_read() { # key -> value
	test -f "$config_file" && grep "^$(echo "$1" | sed_escape)=" "$config_file" | sed "s/^$(echo "$1" | sed_escape)=//" | tail -1
}

cfg_delete() { # key
	test -f "$config_file" && sed -i "/^$(echo $1 | sed_escape).*$/d" "$config_file"
}

cfg_haskey() { # key
	test -f "$config_file" && grep "^$(echo "$1" | sed_escape)=" "$config_file" > /dev/null
}

repo_root=$(cfg_read repository)
[[ -z "$repo_root" ]] && echo "'repository' config value not found." && exit 1
repo_dir="$repo_root/repository"

declare -A clis

discover_clis() {
	local repo_dir_str_length=$((${#repo_dir} + 1))
	local namespaces=$(cfg_read discovery_namespaces)
	[[ -z "$namespaces" ]] && echo "'discovery_namespaces' config value not found." && exit 1
	namespaces=(${namespaces//,/ })
	for i in ${!namespaces[@]};do
		namespaces[$i]="${repo_dir}/${namespaces[$i]//./\/}"
	done
	local artifacts=$(find ${namespaces[@]} -name *.jar | reverse)
	for artifact in ${artifacts}; do
		local artifact="${artifact:$repo_dir_str_length}"
		local groupId=$(echo "$artifact" | rev | cut -d/ -f4- | rev | tr / .)
		local artifactId=$(echo "$artifact" | awk -F/ '{print $(NF-2)}')
		local version=$(echo "$artifact" | awk -F/ '{print $(NF-1)}')
		local cli="$groupId/$artifactId"
		local knownVersion=${clis["$cli"]}
		if [[ ${version} > ${knownVersion} ]];then
			clis["$cli"]="$version"
		fi
	done
}

discover_clis

#TODO make this only run when required
echo "Local Commands in: $repo_dir"
for dep in "${!clis[@]}"
do
	artifact=$(echo "$dep" | awk -F/ '{print $NF}')
	version="${clis[$dep]}"
	pom="$repo_dir/$(echo "$dep" | tr . /)/$version/*$version.pom" 
	pom=$(realpath ${pom})
	groupId=$(echo ${dep} | cut -d/ -f1)
	if test -f "$pom"; then
		echo -e "    $artifact\t$groupId\t$version\t$(cat "$pom" | grep -oPm1 "(?<=<description>)[^<]+")"
	fi
done | column -ts $'\t' | sort | cut -b -$(tput cols)

#TODO Write config options
