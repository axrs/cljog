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
