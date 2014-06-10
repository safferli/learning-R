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

# This is general guide to the first prog assignment. It is to give you some
# direction as to how to go about the problems:
# 
# 1. in setting the function arguments definition i.e. 
# function(directory,pollutant, id=1:332), please follow the guideline as in the
# template for the assignment. Don't try to quote pollutant or directory by
# typing "pollutant" or "directory". Please understand the divide between an
# argument and its value preferably,  put "specdata" in your working directory
# since that is the folder name you will be supplying
# 2. in the function try to get the names of the files, you can do something
# like myFiles <- list.files(pattern="csv") so if you want "023.csv" for eg. you
# get it by myFiles[23], if you want "195.csv" and "203.csv", you do
# myFiles[c(195,203)], etc. but note that for id=1:332, myFiles[id] will give
# you everything
# 3. loop through the files and use rbind to stack them on top of each other
# 4. use the pollutant type to extract the the relevant column
# 5. calculate the mean making sure you set na.rm=TRUE

# sprintf: C-style string formatting
# %03d: for numbers, pad to "3" length by adding 0 to the front
# for(i in id) { 
#   filename = file.path(directory, sprintf("%03d.csv", i))
#   df = read.csv(filename)
# } 

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files
##
## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".
##
## 'id' is an integer vector indicating the monitor ID numbers
## to be used
pollutantmean <- function(directory, pollutant, id = 1:332) {
    # get all filenames
    files <- list.files(directory, pattern="csv")    
    # initialise dataframe so that rbind() can append
    selected_data <- data.frame()
    # loop to read only selected files
    for (i in id) {
        selected_data <- rbind(selected_data, read.csv(paste0(directory, "/", files[i])))
    } # end for loop
    
    # Calculate the mean of the pollutant across all monitors list
    # in the 'id' vector (ignoring NA values)
    pollutant_mean <- mean(selected_data[[pollutant]], na.rm=TRUE)
    # return this, since it's called last: 
    pollutant_mean
}

## testing with known output
#source("pollutantmean.R")
pollutantmean("specdata", "sulfate", 1:10)
## [1] 4.064
pollutantmean("specdata", "nitrate", 70:72)
## [1] 1.706
pollutantmean("specdata", "nitrate", 23)
## [1] 1.281


