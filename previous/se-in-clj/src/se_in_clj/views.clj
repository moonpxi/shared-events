(ns se-in-clj.views
  (:use [hiccup core page]))

(defn main-page []
  (html5
    [:head
     [:title "Testing"]
     [:body
      [:h1 "Main Page"]]]))
