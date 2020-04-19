# cljog

`(= "Clojure Command Jogger" cljog)`

Making Clojure automation scripts and CLI tools run... or at least Jog.

![AXRS](https://circleci.com/gh/axrs/cljog.svg?style=shield)
![](https://img.shields.io/github/v/tag/axrs/cljog?label=Latest%20Version&sort=semver&style=flat-square)
```
   ____ _        _  ___   ____ 
  / ___| |      | |/ _ \ / ___|
 | |   | |   _  | | | | | |  _ 
 | |___| |__| |_| | |_| | |_| |
  \____|_____\___/ \___/ \____|
                                   
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
I decided to create `cljog` for writing Clojure (with some inspiration from [Eric Normand](https://github.com/ericnormand)
Boilerplate for running Clojure as a shebang script [Gist](https://gist.github.com/ericnormand/6bb4562c4bc578ef223182e3bb1e72c5/))
as a Bash replacement.

### Similar Projects

* [closh](https://github.com/dundalek/closh)
* [CLI-matic](https://github.com/l3nz/cli-matic)
* [tools.cli](https://github.com/clojure/tools.cli)

## Installation

1. Download `cljog`. `wget https://raw.githubusercontent.com/axrs/cljog/0.2.0/cljog`
1. Make executable. `chmod +x cljog`
1. Move to a bin directory. `mv cljog /usr/bin/`

## Usage

1. Install `cljog` into a bin directory and make it executable
1. Create a script with the `cljog` interpreter shebang. `#!/usr/bin/env cljog`
1. Make the script executable and invoke it; or run it directly through `cljog`

```bash
./script.clj 
# or
cljog script.clj
```

## Example Scripts

* [Webdriver](example-scripts/webdriver.clj)
* [Echo](example-scripts/echo.clj)

[![asciicast](https://asciinema.org/a/RQgIhwYabsER0HqHcUiVFoIRD.svg)](https://asciinema.org/a/RQgIhwYabsER0HqHcUiVFoIRD)
