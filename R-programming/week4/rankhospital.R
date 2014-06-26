rm(list = ls()); gc(); gc()
options(bitmapType='cairo')
options(scipen = 999)# full numeric output
#require(RODBC)
# require(XML)
require(data.table)
# require(plyr)
# require(dplyr)
# require(reshape2)
#require(zoo)
#require(compiler)
# require(xlsx)
# require(ggplot2)
# require(grid)
# require(scales)
# require(RColorBrewer)

# Define your workspace: "X:/xxx/"
workspace <- "D:/github/learning-R/R-programming/week4/"
#workspace <- "/home/safferli/Documents/R-course/github/R-programming/week4/"
setwd(workspace)

## assignment 4, second part starts here

# Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
# state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
# of the hospital that has the ranking specified by the num argument. For example, the call
# rankhospital("MD", "heart failure", 5)
# would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
# for heart failure. The num argument can take values "best", "worst", or an integer indicating the ranking
# (smaller numbers are better). If the number given by num is larger than the number of hospitals in that
# state, then the function should return NA. Hospitals that do not have data on a particular outcome should
# be excluded from the set of hospitals when deciding the rankings.
# Handling ties. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
# of death. In those cases ties should be broken by using the hospital name. For example, in Texas ("TX"),
# the hospitals with lowest 30-day mortality rate for heart failure are shown here.
# > head(texas)
# Hospital.Name Rate Rank
# 3935
# FORT DUNCAN MEDICAL CENTER 8.1
# 1
# 4085 TOMBALL REGIONAL MEDICAL CENTER 8.5
# 2
# 4103 CYPRESS FAIRBANKS MEDICAL CENTER 8.7
# 3
# 3954
# DETAR HOSPITAL NAVARRO 8.7
# 4
# 4010
# METHODIST HOSPITAL,THE 8.8
# 5
# 3962 MISSION REGIONAL MEDICAL CENTER 8.8
# 6
# Note that Cypress Fairbanks Medical Center and Detar Hospital Navarro both have the same 30-day rate
# (8.7). However, because Cypress comes before Detar alphabetically, Cypress is ranked number 3 in this
# scheme and Detar is ranked number 4. One can use the order function to sort multiple vectors in this
# manner (i.e. where one vector is used to break ties in another vector).
# The function should use the following template.


rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    keep_columns <- rep("NULL", times=46)
    keep_columns[2] <- "character" # Hospital.Name
    keep_columns[7] <- "factor" # State
    keep_columns[c(11, 17, 23)] <- "character" # outcomes, numeric returns error
    # data.table throws errors upon changing to as.numeric later
    # we'll use data.frame for now
    data <- read.csv("outcome-of-care-measures.csv", 
                     colClasses = keep_columns,
                     na.strings = "Not Available",
                     stringsAsFactors = FALSE)
    # http://stackoverflow.com/questions/3796266/change-the-class-of-many-columns-in-a-data-frame
    # no idea why I need to do as.numeric(as.character()), as they *should* be stored as character in the first place!
    # change columns 3,4,5 to numeric
    cols = c(3,4,5)
    data[, cols] = apply(data[, cols], 2, function(x) as.numeric(as.character(x)))
    # data.table for sorting/subsetting magic!
    data <- data.table(data, key = "State")
    
    ## Check that state and outcome are valid
    # is state valid? 
    if(!state %in% data$State) stop("invalid state")
    # is outcome valid?
    possible_outcomes <- c("heart attack", "heart failure", "pneumonia")
    if(!outcome %in% possible_outcomes) stop("invalid outcome")
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    # get column number for outcome variable (+2, since outcomes start at col 3)
    i <- match(outcome, possible_outcomes) + 2
    # select only colums 1,2, and the outcome colum i; only keep correct state
    selected_data <- subset(data, State == state, select = colnames(data)[c(1,2,i)])
    setnames(selected_data, 3, "V3")
    
    # re-code ranking number
    if (num == "best"){
        rank <- 1
    } else if (num == "worst"){
        rank <- which.max(V3)
    } else {
        rank <- num
    }
    
    # return hospital name ([[1]]) from the ordered list of one: lowest death rate
    selected_data[head(order(V3,Hospital.Name), n=1L)][[1]]
}

# which.max(), which.min() to get row number? edj-boston


# > source("rankhospital.R")
# > rankhospital("TX", "heart failure", 4)
# [1] "DETAR HOSPITAL NAVARRO"
# > rankhospital("MD", "heart attack", "worst")
# [1] "HARFORD MEMORIAL HOSPITAL"
# > rankhospital("MN", "heart attack", 5000)
# [1] NA





