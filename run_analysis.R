library(dplyr)
library(plyr)
library(data.table)

#1. Merges the training and the test sets to create one data set.

#Getting all the files
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "/Users/amani/Documents/Coursera-DS/Weekfour.zip")

#Unzipping all the files
unzip(zipfile = "/Users/amani/Documents/Coursera-DS/Weekfour.zip", exdir = "/Users/amani/Documents/Coursera-DS/Weekfour")

#Reading the required test and train files
x_train <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/test/subject_test.txt")


activity_labels <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/activity_labels.txt")
features <- read.table("/Users/amani/Documents/Coursera-DS/Weekfour/UCI HAR Dataset/features.txt")

#Naming the columns of each file appropriately
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activity_labels) <- c("activityID", "activityType")

#Merging test datasets
alltest <- cbind(y_test, subject_test, x_test)
#Merging test datasets
alltrain <- cbind(y_train, subject_train, x_train)
#Merging all test and train datasets to create final dataset
finaldataset <- rbind(alltrain, alltest)


#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#Reading variable names  
colNames <- colnames(finaldataset)

#Vector for mean and std
mean_and_std <- (grep("activityID", colNames) | grep("subjectID", colNames) | grepl("mean..", colNames) | grepl("std...", colNames))

#Subset from merged dataset
setforMeanandStd <- finaldataset[ , mean_and_std == TRUE]


#3 Uses descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setforMeanandStd, activity_labels, by = "activityID", all.x = TRUE)
setWithActivityNames

#4 Appropriately labels the data set with descriptive variable names. 
colnames(setWithActivityNames)<-gsub("^t", "time", colnames(setWithActivityNames))
colnames(setWithActivityNames)<-gsub("^f", "frequency", colnames(setWithActivityNames))
colnames(setWithActivityNames)<-gsub("Acc", "Accelerometer", colnames(setWithActivityNames))
colnames(setWithActivityNames)<-gsub("Gyro", "Gyroscope", colnames(setWithActivityNames))
colnames(setWithActivityNames)<-gsub("Mag", "Magnitude", colnames(setWithActivityNames))
colnames(setWithActivityNames)<-gsub("BodyBody", "Body", colnames(setWithActivityNames))


#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Making second tidy data set

#Getting the mean of all variables by subject and activity
final_mean <- df %>% 
  group_by(subjectID,activityType, activityID) %>% 
  summarize_all(mean)
#Ordering the data by subject ID and activity ID
tidy_data <- final_mean[order(final_mean$subjectID, final_mean$activityID), ]

#Writing second tidy data set into a txt file
write.table(tidy, file="tidy_data.txt", row.names = FALSE, col.names = TRUE)


