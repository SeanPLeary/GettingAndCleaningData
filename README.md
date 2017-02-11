#### Project Summary

This project is an assignment from the Coursera/Johns Hopkins online data science course Getting and Cleaning Data. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set using a single R script named run_analysis.R. 
The data comes from the Human Activity Recognition Using Smartphones Data Set project at the UCI Machine Learning Repository and consists of data collected from the accelerometers from the Samsung Galaxy S smartphone.  
See the included codebook.md for more information

#### Requirements of the Assignment

Create one R script called ```run_analysis.R``` that does the following:

	1. **DONE** Merges the training and the test sets to create one data set.
	2. **DONE** Extracts only the measurements on the mean and standard deviation for each measurement.
	3. **DONE** Uses descriptive activity names to name the activities in the data set
	4. **DONE** Appropriately labels the data set with descriptive activity names.
	5. **DONE** Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### Steps to Work on the Project

Download and unzip the data source. 
Set the working directory to the parent folder of the ```UCI HAR Dataset```
Put ```run_analysis.R``` script in the working directory
Run ```run_analysis.R```
The script outputs two text files to the working directory: one fomatted ```TidyData.csv``` and one unformatted ```TidyData.txt```


#### Dependencies

packages: ```dplyr``` , ```tibble```
 

#### References

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Data Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


