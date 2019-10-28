(ns io.axrs.cli.example.core
  (:require
    [io.jesi.backpack.random :as rnd]))

(defn -main [& args]
  (println "Hello! from the example lib")
  (println "Clojure version:" *clojure-version*)
  (println "Command line args:" *command-line-args*)
  (println "Args: " args)
  (println "Random string:" (rnd/alpha-numeric)))
