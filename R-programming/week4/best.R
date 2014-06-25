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

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

head(outcome)
names(outcome) 

## You may get a warning about NAs being introduced; that is okay
outcome[, 11] <- as.numeric(outcome[, 11])

hist(outcome[, 11])
             
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
    state <- "TX" # testing
    subset(data, State == state, select = colnames(data)[c(1,2,i)]
           )[head(order(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.Name), n=1L)][[1]]
}


mean(subset(data, Ozone>31 & Temp>90)$Solar.R)
As with [.data.frame, compound queries can be concatenated on one line; e.g.,
         
         DT[,sum(v),by=colA][V1<300][tail(order(V1))]
         # sum(v) by colA then return the 6 largest which are under 300


11. Number of Hospitals whose 30-Day Death (Mortality) Rates from Pneumonia are No
different than U.S. National Rate: integer Lists the number of hospitals for each
measure/category combination.

17. Number of Hospitals whose 30-Day Readmission Rates from Heart Attack are
Number of Cases Too Small: integer Lists the number of hospitals for each
measure/category combination.

23. Number of Hospitals whose 30-Day Readmission Rates from Pneumonia are No
different than U.S. National Rate: integer Lists the number of hospitals for each
measure/category combination.




The function should check the validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message "invalid state". If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message "invalid outcome".



best2 <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv")
    outcomes <- c('heart attack', 'heart failure', 'pneumonia')
    indices <- c(11, 17, 23)
    
    if (!state %in% data$State) stop("invalid state")
    if (!outcome %in% outcomes) stop("invalid outcome")
    
    i <- indices[match(outcome, outcomes)]
    hospitals <- data[data$State == state, c(2, i)]
    hospitals[, 2] <- as.numeric(as.character(hospitals[, 2]))
    hospitals <- na.omit(hospitals)
    names(hospitals) <- c("name", "deaths")
    min_deaths <- min(hospitals$deaths)
    candidates <- hospitals[hospitals$deaths == min_deaths, ]$name
    return(as.character(sort(candidates)[1]))
}




if(FALSE) {

2
Finding the best hospital in a state
Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
outcome should be excluded from the set of hospitals when deciding the rankings.
Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b", "c",
                                                                                     and "f" are tied for best, then hospital "b" should be returned).
The function should use the following template.
best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
}
The function should check the validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message "invalid state". If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message "invalid outcome".
Here is some sample output from the function.
> source("best.R")
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"
> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"
> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"
> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"
> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state
> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
>
    2
Save your code for this function to a file named best.R.

}


