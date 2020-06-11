# 1.3.0

Added:
* Ability to run scripts using https://github.com/borkdude/babashka (if installed) by providing as first flag `--bb`
  in shebang line or directly after execution
  > Note: babashka cannot load all java dependencies (as it's not a true JVM), so milage may vary

# 1.2.0

Added:
* Dependency on `clojure-goes-fast/lazy-require`

Changed:
* Lazily load additional namespaces when required. Provides slightly more performance when booting into scripts

# 1.1.0

Added:
* Ability to control own `JAVA_OPTS` by using `CLJOG_JAVA_OPTS` environment variable. Resolves #33

# 1.0.1

Fixed:
* Forwarding args to scripts with extra shebang features

# 1.0.0

Added:
* `--deps` flag for loading `deps.edn` (within the script directory) at launch
* `--deps=file.edn` flag for loading `file.edn` (relative to the script directory) at launch
* `deps` function support for loading `deps.edn` formatted files with `java.io.File` or absolute path string

Removed:
* `--launch-deps` in favour of `--deps`
* Dependency on `column`

Misc:
* Upgraded `Pomegranate` to `1.2.0`
* Added CI support and extended test suite

# 0.4.1

Fixed:
* masOS compatible readlink without 3rd party. Resolves #32

# 0.4.0

Added:
* *script-dir* for current running script

Fixed:
* No longer attempts to create or use config file if not required

# 0.3.2

Fixed:
* Passing `--launch-deps` extra args when running under environments using split-string processing by allowing 
  `\"` to escape quotes

# 0.3.1

Fixed:
* Passing extra args to scripts using `--launch-deps`

# 0.3.0

Added:
* Ability to load dependencies on script launch. [Example](./example-scripts/launch_deps.clj)

Fixed:
* Unit Tests

# 0.2.1

Fixed:
* Running CLIs including CWD `src` paths

# 0.2.0

Added:
* Auto discovery and set of local repository when the config file doesn't exist and mvn is installed
* Config set, read, and print options
* Extended usage help to be more helpful
* Version flag

Fixed:
* Removed dependency on `tput` which may not be installed by default
* Check for installed `column` command before invoking when displaying installed commands

# 0.1.1

Fixed:
* Added JVM OPT `clojure.spec.skip-macros=true` to improve overall runtime time - Thanks @AndreTheHunter
* Clojure `Compiler/LOADER` is set for the current thread resolving unable to find resources issues

# 0.1.0

Added:
* First pass of sub-command remote discovery and installation

# 0.0.7

* Renamed project from `cljmd` to `cljog` to avoid conflicts with existing GitHub project

# 0.0.6

Fixed:
* Reduced the amount of dependencies loaded by Pomegranate - Thanks @AndreTheHunter
* Hushed the pre-load output when running as a script - Thanks @AndreTheHunter

# 0.0.5

Fixed:
* Passing args into sub-commands
* Check to make sure bash if version 4+ for associative arrays
* Swap out `grep` for `awk` when extracting pom description because of potential missing `-P` flag

# 0.0.4

Added:
* First pass of sub-command discovery and invocation with multiple `groupId` support
* `--list` or `-l` arg to list installed sub-commands. e.g. `cljmd --list`
* Some useful error messages
* Simple config read/write tools

# 0.0.3

* Renamed project from `cljash` to `cljmd` to avoid conflicts with existing GitHub project

Fixed:
* Clojure executable detection

# 0.0.2 - Broken

Added:
* Clojure executable detection
* Version variable
* Script existence checking

# 0.0.1

Initial release mixing bash and clojure
