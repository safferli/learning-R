rm(list=ls())
gc();gc()

#library(ggplot2)
library(dplyr)

wd <- "D:/github/learning-R/cleaning-data/course_project"
setwd(wd)

# The purpose of this project is to demonstrate your ability to collect, work
# with, and clean a data set. The goal is to prepare tidy data that can be used
# for later analysis. You will be graded by your peers on a series of yes/no
# questions related to the project. You will be required to submit: 1) a tidy
# data set as described below, 2) a link to a Github repository with your script
# for performing the analysis, and 3) a code book that describes the variables,
# the data, and any transformations or work that you performed to clean up the
# data called CodeBook.md. You should also include a README.md in the repo with
# your scripts. This repo explains how all of the scripts work and how they are
# connected.
# 
# One of the most exciting areas in all of data science right now is wearable
# computing - see for example this article . Companies like Fitbit, Nike, and
# Jawbone Up are racing to develop the most advanced algorithms to attract new
# users. The data linked to from the course website represent data collected
# from the accelerometers from the Samsung Galaxy S smartphone. A full
# description is available at the site where the data was obtained:
# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set. Extracts only
# the measurements on the mean and standard deviation for each measurement. Uses
# descriptive activity names to name the activities in the data set 
# Appropriately labels the data set with descriptive variable names. Creates a
# second, independent tidy data set with the average of each variable for each
# activity and each subject.
# 
# Good luck!

###
# 1) merge training and testing dataset
###

# variable names
feature_names <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors=FALSE)

# read training data
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training_activity <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
training_subject <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

training_df <- tbl_df(cbind(training, training_activity, training_subject))
names(training_df) <- c(feature_names$V2, "activity", "subject")

# read test data
test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_activity <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
test_subject <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

test_df <- tbl_df(cbind(test, test_activity, test_subject))
names(test_df) <- c(feature_names$V2, "activity", "subject")

# merge the two datasets
full_data <- rbind(test_df, training_df)


###
# 2) pick only mean and stds variables
###

# keep all cols with mean() or std() as Varname
mean_std_cols <- grep("mean\\(\\)|std\\(\\)", feature_names[, 2], ignore.case=TRUE)
# keep the last two cols (activity, subject) as well
mean_std_cols <- append(mean_std_cols, c(length(full_data)-1, length(full_data)))

# pick only selected data
selected_data <- full_data[, mean_std_cols]


###
# 3) descriptive activity names
###

# activity labels
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

selected_data$activity <- factor(selected_data$activity, levels=c(1,2,3,4,5,6),
                                       labels=activity_labels$V2)


###
# 4) appropriately label the data set with desctiptive variable names
###

# already done in step 1, by setting the names() 


###
# 5) create independent data set with the average of each variable for each activity and subject
###

# needs dplyr>=0.2
means_data <- selected_data %>%
    group_by(activity, subject) %>%
    summarise_each(funs(mean)) 

# test <- select(selected_data, activity, subject, `tBodyAcc-mean()-X`) %>%
#     arrange(activity, subject)

# add "means_of_" to all variable names, except the grouping vars
names(means_data) <- gsub("^(t|f)","mean_of_\\1", names(means_data))

# write tidy dataset
write.table(means_data, "tidy.txt", sep="\t")












