#if(!require("devtools")) install.packages("devtools")
#library("devtools")
#library(httr)
#set_config(use_proxy(url="10.26.0.16", port=3128))
#install_github("leeper/meme")

library("meme")
templates <- get_templates("memecaptain")

par( mfrow = n2mfrow(length(templates)), mar=rep(0,4), mgp=rep(0,3))
invisible(lapply(templates, plot))

plot(allthethings <- create_meme(templates[[2]], "Code", "all the things!"))