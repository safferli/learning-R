library(httr)
set_config(use_proxy(url="10.26.0.16", port=3128))
library(jsonlite)

d3 <- fromJSON("http://eu.battle.net/api/d3/profile/safferli-2527/")

rockhount <- fromJSON("http://eu.battle.net/api/d3/profile/Rockhount-2231/")
