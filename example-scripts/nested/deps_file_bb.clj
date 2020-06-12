#!/usr/bin/env cljog --bb --deps=../deps_file.edn
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
(println (first *command-line-args*))
(println "This script was run with additional deps provided by relative ../deps_file.edn")
