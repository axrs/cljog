#!/usr/bin/env cljog
(deps (str *script-dir* "/deps_file.edn"))
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
(println (first *command-line-args*))
(println "This script was run with additional deps loaded at runtime")
