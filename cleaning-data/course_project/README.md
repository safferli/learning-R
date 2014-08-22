Getting and Cleaning Data: Course Project
=========================================


Introduction
------------

This repository contains the files for the course project of the Coursera course "Getting and Cleaning data", part of the Data Science specialization: https://class.coursera.org/getdata-006 


About the raw data
------------------

The data linked to from the course website represent data collected
from the accelerometers from the Samsung Galaxy S smartphone. A full
description is available at the site where the data was obtained:
 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
Here are the data for the project:
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There is a training and a test dataset (and folder) if you unzip the file. 

* features (561) are unlabeled and can be found in the x_test.txt. 
* activity labels are in the y_test.txt file.
* test subjects are in the subject_test.txt file.

And again for the training set.


About the script 
----------------

The script `run_analysis.R` will merge the test and training sets together in a dataset called `full_data`, pick only the variables that contain means and standard deviations and push these into a dataset called `selected_data`, and finally will create a tidy dataset of the means of these selected variables (grouped by activity and subject) in a dataset called `means_data`. 

### Prerequisites for this script:

1. the UCI HAR Dataset must be downloaded and extrated into the working directory
2. this directory must be called called "UCI HAR Dataset"
3. you will need the R library `dplyr>=0.2` installed on your system


About the Code Book
-------------------

The `codeBook.md` file explains the calculations and the resulting data and variables in more detail. 
