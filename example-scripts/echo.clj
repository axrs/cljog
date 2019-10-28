#!/usr/bin/env cljog
(deps '[[io.jesi/backpack "3.3.0"]])
(require '[io.jesi.backpack.random :as rnd])

(println "Hello! from the other side")
(println "Script:" *script*)
(println "Current working dir:" *cwd*)
(println "Clojure version:" *clojure-version*)
(println "cljog version:" *cljog-version*)
(println "Command line args:" *command-line-args*)
(println "Random string:" (rnd/alpha-numeric))
