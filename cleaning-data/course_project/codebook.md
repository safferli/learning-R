# Coursera: Getting and Cleaning Data

## Codebook

### original dataset

This dataset is derived from the *Human Activity Recognition Using Smartphones Data Set* which was originally made avaiable at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The `README.txt` and `features.txt` files contain all necessary descriptions for this dataset. 

### script procedure

* Data was obtained from, and is explained in full detail at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* The base dataset is available at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The script `run_analysis.R` completes the following steps: 
    1. reads the training and the test dataset from the directory "UCI HAR Dataset" in your working directory
    1. for each training and test dataset, joins the features with the activity and the subjects
    1. then joins both the training and the test dataset into a dataframe called `full_data`, and adds desctiptive variable labels from the original data folder file `UCI HAR Dataset/features.txt`
    1. it then generates a dataframe called `selected_data` by only picking the activity and the subject column, as well as all columns which contain the words "mean" or "std", thus selecting only the means and standard deviations of the features
    1. the numeric activity factors are replaced by a descriptive string found in `UCI HAR Dataset/activity_labels.txt`
    1. finally, it creates a dataframe `means_data`, which consists of only the means of all features, grouped by each activity and subject
    1. all aggregated variables have the string `mean_of_` prefixed to the original variable name (e.g. `tBodyAcc-mean()-X` -> `means_of_tBodyAcc-mean()-X`)
    1. the `means_data` data is stored as a file `tidy.txt` in your working directory