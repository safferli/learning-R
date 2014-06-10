#rm(list = ls()); gc(); gc()
#options(bitmapType='cairo')
#options(scipen = 999)# full numeric output
# require(RODBC)
# require(XML)
#require(data.table)
# require(plyr)
# require(dplyr)
# require(reshape2)
# require(zoo)
# require(compiler)
# require(xlsx)
# require(ggplot2)
# require(grid)
# require(scales)
# require(RColorBrewer)

# Define your workspace: "C:/xxx/"
workspace <- "/home/safferli/Documents/R-course/github/R-programming/week2/"
setwd(workspace)


complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
# there is a complete.cases() function

}




## testing with known output
source("complete.R")
complete("specdata", 1)
##   id nobs
## 1  1  117
complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
complete("specdata", 3)
##   id nobs
## 1  3  243
