library(dplyr)
library(rCharts)
library(rvest)

# https://aschinchon.wordpress.com/2015/10/12/a-visualization-of-the-100-greatest-love-songs-ft-d3-js/

wd <- "D:/github/learning-R/"
setwd(wd)

heart <-
  function(r,x) {
    ifelse(abs(x) < 2, ifelse(r %% 2 == 0, sqrt(1 - (abs(
      x
    ) - 1) ^ 2), acos(1 - abs(x)) - pi), 0)
  } 

data.frame(x = seq(
    from = -3, to = 3, length.out = 100
  )) %>%
  mutate(y = jitter(heart(row_number(), x), amount = .1)) -> df

# love_songs <- read_html("http://www.cs.ubc.ca/~davet/music/list/Best13.html") 
love_songs <- read_html(paste0(wd, "VH1 - 100 Greatest Love Songs (Music Database   Dave Tompkins).htm"))

love_songs %>%
  html_nodes("table") %>%
  .[[2]] %>%
  html_table(header=TRUE, fill = TRUE) %>%
  cbind(df) -> df

m1=mPlot(x = "x",  y = "y",  data = df,  type = "Line")
m1$set(pointSize = 5, 
       lineColors = c('red', 'red'),
       width = 850,
       height = 600,
       lineWidth = 2,
       hoverCallback = "#! function(index, options, content){
       var row = options.data[index]
       return '<b>' + row.ARTIST + '</b>' + '<br/>' + row.TITLE} !#",
       grid=FALSE,
       axes=FALSE)
m1$save('Top_100_Greatest_Love_Songs.html', standalone = TRUE)

