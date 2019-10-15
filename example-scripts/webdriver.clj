#!/usr/bin/env cljmd
; A simple example of using Etaoin with cljmd to automate a browser adapted from
; https://github.com/igrishaev/etaoin#getting-stated
(deps '[[etaoin "0.3.5"]])

(use 'etaoin.api)
(require '[etaoin.keys :as k])
(require '[clojure.test :refer [deftest run-tests testing is]])

(defn- assert-url [driver expected]
  (is (= expected (get-url driver))))

(defn- assert-title [driver expected]
  (is (= expected (get-title driver))))

(deftest clojure-wikipedia-test

  (testing "Searching Wikipedia for Clojure"

    (doto (chrome)
      (go "https://en.wikipedia.org/")
      (wait-visible [{:id :simpleSearch} {:tag :input :name :search}])
      (fill {:tag :input :name :search} "Clojure programming language")
      (fill {:tag :input :name :search} k/enter)
      (wait-visible {:class :mw-search-results})

      (click [{:class :mw-search-results} {:class :mw-search-result-heading} {:tag :a}])
      (wait-visible {:id :firstHeading})

      (assert-url "https://en.wikipedia.org/wiki/Clojure")
      (assert-title "Clojure - Wikipedia")
      (quit))))

(let [{:keys [fail error] :as results} (run-tests 'user)]
  (when (or (pos? fail) (pos? error))
    (throw (ex-info "Failing tests" results))))
