(ns se-in-clj.handler
  (:use compojure.core
        se-in-clj.views
        [hiccup.middleware :only (wrap-base-url)])
  (:require [compojure.route :as route]
            [compojure.handler :as handler]
            [compojure.response :as response]))

(defroutes main-routes
  (GET "/" [] (main-page))
  (GET "/show/:id" [id] (str "ID is " id " indeed"))
  (route/resources "/")
  (route/not-found "Page not found"))

(def app
  (-> (handler/site main-routes)
      (wrap-base-url)))
