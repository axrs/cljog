#!/usr/bin/env cljog --deps
(deps '[[medley "1.3.0"]])
(require '[io.jesi.backpack.random :as rnd]
         '[medley.core :refer [assoc-some]])
(println (rnd/uuid-str))
(println (first *command-line-args*))
(println (assoc-some {} :a 1))
(println "This script was run with additional deps provided by deps.edn")
