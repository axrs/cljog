# cljash

Clojure for Automation Scripting and CLI Tools

```
 _______    _         _________   _______    _______            
(  ____ \  ( \        \__    _/  (  ___  )  (  ____ \  |\     /|
| (    \/  | (           )  (    | (   ) |  | (    \/  | )   ( |
| |        | |           |  |    | (___) |  | (_____   | (___) |
| |        | |           |  |    |  ___  |  (_____  )  |  ___  |
| |        | |           |  |    | (   ) |        ) |  | (   ) |
| (____/\  | (____/\  |\_)  )    | )   ( |  /\____) |  | )   ( |
(_______/  (_______/  (____/     |/     \|  \_______)  |/     \|
```
---

Developers tend to automate all the things. From cloud infrastructure setup ([Terraform](https://www.terraform.io/)) and
browser control ([Selenium](https://www.seleniumhq.org/)); to the day to day tasks of performing updates, and performing
system backups. It helps us to:
* focus of other activities
* reduce human error and risk
* share efficiencies
* become DRY

## Why?

I've always wanted to move away from Bash for automation into something that:
* is standalone
* allows specifying dependencies and required versions
* has an existing and established library of code available
* easy to write, run, extend, and share
* is performant
* interpreted (no compilation necessary)
* can be considered cross-platform
* supports simple sub-command discovery and invocation (similar to git)
* easy to setup

Python, Node.js, and Java are all languages that can be used for automation, if you can use the standard libraries.
Anything more complex requires additional steps to install dependencies and maintain. Inspired Alan Franzoni and his
article [Standalone, single-file, editable Python scripts WITH DEPENDENCIES](https://www.franzoni.eu/single-file-editable-python-scripts-with-dependencies/), 
I decided to create `cljash` for writing Clojure (with some inspiration from [Eric Normand](https://github.com/ericnormand)
Boilerplate for running Clojure as a shebang script [Gist](https://gist.github.com/ericnormand/6bb4562c4bc578ef223182e3bb1e72c5/))
as a Bash replacement.

### Similar Projects

* [closh](https://github.com/dundalek/closh)
* [CLI-matic](https://github.com/l3nz/cli-matic)
* [tools.cli](https://github.com/clojure/tools.cli)

## Installation

TODO

## Usage

1. Install `cljash` into a bin directory and make it executable
1. Create a script with the `cljash` interpreter shebang. `#!/usr/bin/env cljash`
1. Make the script executable and invoke it; or run it directly through `cljash`

```bash
./script.clj 
# or
cljash script.clj
```

## Example Script

[![asciicast](https://asciinema.org/a/DemWRiWRkRz2v4ocFCHtarKxG.svg)](https://asciinema.org/a/DemWRiWRkRz2v4ocFCHtarKxG)

```clojure
#!/usr/bin/env cljash
(deps '[[io.jesi/backpack "3.3.0"]])
(require '[io.jesi.backpack.random :as rnd])

(println "Hello! from the other side")
(println "Script: " script)
(println "Current working dir:" (System/getProperty "user.dir"))
(println "Clojure version: " *clojure-version*)
(println "Command line args: " *command-line-args*)
(println "Random string:" (rnd/alpha-numeric))
```

TODO

## Todo

- [ ] Shebang interpreter with dynamic dependency loading
- [ ] Dynamic sub-command location and invocation
