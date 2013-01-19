(defproject se-in-clj "0.0.1"
  :description "FIXME: write description"
  :dependencies [[org.clojure/clojure "1.4.0"]
                 [compojure "1.1.5"]
                 [hiccup "1.0.2"]]
  :plugins [[lein-ring "0.8.0"]]
  :ring {:handler se-in-clj.handler/app})
