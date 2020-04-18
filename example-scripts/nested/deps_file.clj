#!/usr/bin/env cljog --deps=../deps_file.edn
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
(println (first *command-line-args*))
