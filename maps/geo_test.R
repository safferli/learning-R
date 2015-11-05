rm(list = ls()); gc(); gc()
options(bitmapType='cairo', scipen = 999)
library(data.table)
library(dplyr)
library(ggplot2)
library(scales)
library(geojsonio)
library(leafletR)
library(rgdal)
library(rgeos)
library(sp)
f.norm <- function(x) (x-min(x))/(max(x)-min(x))
cols <- c("#e7f0fa", "#c9e2f6", "#95cbee", "#0099dc", "#4ab04a", "#ffd73e",
          "#eec73a", "#e29421", "#e29421", "#f05336", "#ce472e")


## https://rpubs.com/tmieno2/68747


country_codes <- fread("D:/R/info/country_codes.csv") # Our lookup list (see copy on Virga)
raw_data <- fread("D:/data/population_data.csv") %>% # From Wikipedia
  merge(country_codes, by = "country") %>%
  setnames("code3", "id")
hexmap <- readOGR("d:/data/wargames/geojson/admin0_polygons.json", "OGRGeoJSON") # Downloaded from http://www.projectlinework.org
hexmap_data <- fortify(hexmap, region="ISO_A3")


t <- max(raw_data$population)
br <- ceiling(exp(seq(1, log(t), by = log(t)/10))/10)*10
q <- ggplot() +
  geom_map(data=hexmap_data, map=hexmap_data, aes(x=long, y=lat, map_id=id), color="black") +
  geom_map(data=raw_data, map=hexmap_data, aes(map_id=id, fill=population), color="black") +
  scale_fill_gradientn(colours=cols, breaks = br, values=f.norm(log(seq(1, 100, by = 10))), trans="log") +
  coord_equal() +
  theme_bw() +
  labs(x=NULL, y=NULL, title = "Total population by country") +
  theme(panel.border=element_blank()) +
  theme(panel.grid=element_blank())
# ggsave("D:/data/population.jpeg", plot = q, width = 30, height = 15)
