#!/usr/bin/env cljog --deps=deps_file_without_deps.edn
(deps '[[io.jesi/backpack "5.2.0"]])
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
(println (first *command-line-args*))
(println "This script was run with a deps file missing the :deps key")
