
# The purpose of this project is to demonstrate ability to collect,
# work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis.

# Requirements:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.


# load dependencies
library(dplyr)
library(tibble)


# read features 561 rows x 2 cols (featureNumber,featureName)
features <- read.table("./UCI HAR Dataset/features.txt")

# only interested in 2nd column
featureNames = features[,2]

# select only mean and std features; note class(featureNamesFiltered) is logical
featureNamesFiltered  <- grepl("mean\\(\\)|std\\(\\)", featureNames)


# read training data (561 cols) and assign col names
subjectTrain <- (read.table("./UCI HAR Dataset/train/subject_train.txt"))
names(subjectTrain) <- c("subject")
activityNumberTrain <- (read.table("./UCI HAR Dataset/train/y_train.txt"))
names(activityNumberTrain) <- c("activityNumber")
activityDataTrain <- (read.table("./UCI HAR Dataset/train/X_train.txt"))

# populate column names with features
names(activityDataTrain) <- featureNames

# select data only asscociated with mean and std
activityDataTrainFiltered <- activityDataTrain[,featureNamesFiltered]


# combine to form training data set
trainDataSet <- tbl_df(cbind(subjectTrain,activityNumberTrain,activityDataTrainFiltered))


# read testing data (561 cols)
subjectTest <- (read.table("./UCI HAR Dataset/test/subject_test.txt"))
names(subjectTest) <- c("subject")
activityNumberTest <- (read.table("./UCI HAR Dataset/test/y_test.txt"))
names(activityNumberTest) <- c("activityNumber")
activityDataTest <- (read.table("./UCI HAR Dataset/test/X_test.txt"))

# populate column names with features
names(activityDataTest) <- featureNames

# select data only asscociated with mean and std
activityDataTestFiltered <- activityDataTest[,featureNamesFiltered]

# combine to form testing data set
testDataSet <- tbl_df(cbind(subjectTest,activityNumberTest,activityDataTestFiltered))


# Merge test and train data sets
mergedDataSet <- rbind(testDataSet,trainDataSet)



# read activity labels 6 rows x 2 columns 
activityLabels <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
colnames(activityLabels) <- c("activityNumber","activity")

# assign acivityLabels using common activityNumber column
tidyDataTable <- tbl_df(merge(activityLabels, mergedDataSet , by ="activityNumber", all.x=TRUE))



# drop activityNumber column
tidyDataTable <- select(tidyDataTable,-activityNumber)

#  create a second, independent tidy data set with the average of each variable 
#  for each activity and each subject
dataSummaryStats<- aggregate(. ~ subject - activity, data = tidyDataTable, FUN = "mean") 
tidyDataTable <- tbl_df(arrange(dataSummaryStats,subject,activity))



# Appropriately label the data set with descriptive variable names:
names(tidyDataTable) <- gsub("mean", "Mean", names(tidyDataTable))
names(tidyDataTable) <- gsub("std", "Std", names(tidyDataTable))
names(tidyDataTable) <- gsub("BodyBody", "Body", names(tidyDataTable))
names(tidyDataTable) <- gsub("Mag", "Magnitude", names(tidyDataTable))
names(tidyDataTable) <- gsub("Acc", "Accelerometer", names(tidyDataTable))
names(tidyDataTable) <- gsub("Gyro", "Gyroscope", names(tidyDataTable))
names(tidyDataTable) <- gsub("^t", "time", names(tidyDataTable))
names(tidyDataTable) <- gsub("^f", "frequency", names(tidyDataTable))
names(tidyDataTable) <- gsub("-X", "_X-direction", names(tidyDataTable))
names(tidyDataTable) <- gsub("-Y", "_Y-direction", names(tidyDataTable))
names(tidyDataTable) <- gsub("-Z", "_Z-direction", names(tidyDataTable))
names(tidyDataTable) <- gsub("\\()", "", names(tidyDataTable))




# save data to file in txt and csv formats
write.csv(tidyDataTable, "TidyData.csv")
write.table(tidyDataTable, "TidyData.txt" , row.name=FALSE)
  
