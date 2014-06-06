rm(list = ls()); gc(); gc()
options(bitmapType='cairo')
options(scipen = 999)# full numeric output
require(RODBC)
# require(XML)
require(data.table)
# require(plyr)
# require(dplyr)
# require(reshape2)
require(zoo)
require(compiler)
# require(xlsx)
# require(ggplot2)
# require(grid)
# require(scales)
# require(RColorBrewer)

# Define your workspace: "X:/xxx/"
workspace <- "D:/github/learning-R/R-programming/week1/"

data <- read.csv(paste0(workspace, "hw1_data.csv"))

head(data, n = 2L)
nrow(data)
tail(data, n = 2L)

# value of Ozone in the 47th row
data$Ozone[47]
# number of missing values of Ozone
#sum(is.na(data$Ozone))
sapply(data, function(x) sum(is.na(x)))
# column means (rowMeans() also exists)
colMeans(data, na.rm=TRUE)
# subset rows with Ozone > 31 and Temp > 90
Oz <- c(data$Ozone>31)
Te <- c(data$Temp>90)

# data.table allows for much nicer subsetting/etc!
data <- data.table(data)
#data[Ozone>30, c(1, 2), with = FALSE]
#data[Ozone>30 & Temp > 90, meanOzone := mean(Ozone)]
subset(data, Ozone>31 & Temp>90)
# using "$Solar.R" is possible, because we've legally created a df 
meanSolar <- mean(subset(data, Ozone>31 & Temp>90)$Solar.R)
subset(data, Month==6)
meanTemp <- mean(subset(data, Month==6)$Temp)
subset(data, Month==5)
maxOzone <- max(subset(data, Month==5 & !is.na(Ozone))$Ozone)


## additional data.table command fancy shit!
# subset(df, x > 1 & , select = c('a', 'b'))
# 
# df[x==1, y := x-1]
# 
# df[x>10, y := x-1, by = c('a', 'b')]
# 
# df[x>10, list(y = mean(x)), by = c('a', 'b')]
# 
# # set index keys
# setkey(df, a)
# setkey(df2, a)
# # merge on key a automatically
# merge(df, df2)



