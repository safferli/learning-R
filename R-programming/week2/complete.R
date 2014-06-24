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
#workspace <- "/home/safferli/Documents/R-course/github/R-programming/week2/"
workspace <- "D:/github/learning-R/R-programming/week2/"
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
  
    # get all filenames
    files <- list.files(directory, pattern="csv")    
    # initialise dataframe so that rbind() can append
    total <- data.frame()
    # loop to read only selected files, and directly parse the complete.cases()
    for (i in id) {
        # selected_data <- rbind(selected_data, read.csv(paste0(directory, "/", files[i])))
        total <- rbind(total, 
            # bind the two colums: id; nobs
            cbind(
                # name the id -- it's i!
                as.integer(c(i)), 
                # count the number of complete cases
                sum(complete.cases(read.csv(paste0(directory, "/", files[i]))))
            )#cbind
        )#rbind
    } # end for loop
    
    # correct output naming and returning
    colnames(total) <- c("id","nobs")
    total
}# complete()




## testing with known output
#source("complete.R")
#complete("specdata", 1)
##   id nobs
## 1  1  117
#complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
#complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
#complete("specdata", 3)
##   id nobs
## 1  3  243
