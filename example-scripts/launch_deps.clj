#!/usr/bin/env cljog --launch-deps io.jesi/backpack {:mvn/version "4.2.1"}
(require '[io.jesi.backpack.random :as rnd])
(println (rnd/uuid-str))
