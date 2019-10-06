#!/usr/bin/env cljash
(deps '[[io.jesi/backpack "3.3.0"]])
(require '[io.jesi.backpack.random :as rnd])

(println "Hello! from the other side")
(println "Script: " script)
(println "Current working dir:" (System/getProperty "user.dir"))
(println "Clojure version: " *clojure-version*)
(println "Command line args: " *command-line-args*)
(println "Random string:" (rnd/alpha-numeric))
