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

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    total<-numeric()
    for(file in list.files(directory)){
        pollutantData<-read.table(paste(directory,"/",file,sep=""),sep=",",header=TRUE)
        comple<-nrow(pollutantData[complete.cases(pollutantData),])
        if(comple>threshold){
            #total<-rbind(total,cor(pollutantData$nitrate,pollutantData$sulfate,use="complete.obs"))
            total<-c(total,cor(pollutantData$nitrate,pollutantData$sulfate,use="complete.obs"))
        }
    }
    as.numeric(total)
}