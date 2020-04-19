#!/usr/bin/env cljog --deps=deps_file_without_deps.edn
(deps '[[io.jesi/backpack "5.1.0"]])
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
(println (first *command-line-args*))
(println "This script was run with additional deps provided by deps_file.edn")
