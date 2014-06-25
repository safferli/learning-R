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

## assignment 4, first part starts here

best <- function(state, outcome) {
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
    
    ## Return hospital name in that state with lowest 30-day death rate
    # get column number for outcome variable (+2, since outcomes start at col 3)
    i <- match(outcome, possible_outcomes) + 2
    # select only colums 1,2, and the outcome colum i; only keep correct state
    selected_data <- subset(data, State == state, select = colnames(data)[c(1,2,i)])
    setnames(selected_data, 3, "V3")
    # return hospital name ([[1]]) from the ordered list of one: lowest death rate
    selected_data[head(order(V3,Hospital.Name), n=1L)][[1]]
}

# remove start text from variable names: 
# setnames(data, names(data), gsub('Hospital.30.Day.Death..Mortality..Rates.from.', '', names(data)))

## with=F in data.table so that 2 references the column
## data[, 2, with = TRUE]
## data[, 2, with = FALSE]

# mean(subset(data, Ozone>31 & Temp>90)$Solar.R)
# As with [.data.frame, compound queries can be concatenated on one line; e.g.,
#          
#          DT[,sum(v),by=colA][V1<300][tail(order(V1))]
#          # sum(v) by colA then return the 6 largest which are under 300

