# This is the code book for the project

## How to get to the tidy_data.txt:
1. Download data from the link below and unzip it into working directory of R Studio.
2. Execute the R script.

## About the source data
The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available here:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for this project is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## About R script
File with R code "run_analysis.R" performs the 5 following steps:  
  
  1. Merge the training and the test sets to create one data set.

      * Getting all the files [train files, test files, activity labels file, and features file]
      * Unzipping all the files
      * Reading the required test and train files [x_train, y_train, subject_train, x_test, y_test, subject_test, activity labels, features]
      * Naming the columns of each file appropriately
      * Merging test datasets
      * Merging train datasets
      * Merging all test and train datasets to create final dataset

2. Extract only the measurements on the mean and standard deviation for each measurement. 

      * Reading variable names 
      * Vector for mean and std
      * Subset from merged dataset

3. Use descriptive activity names to name the activities in the data set

4. Appropriately labeling the data set with descriptive variable names  

5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject   
      * Making second tidy data set 
          * Getting the mean of all variables by subject and activity
          * Ordering the data by subject ID and activity ID

      * Writing second tidy data set into a txt file   

The code assumes all the data is present in the same folder, un-compressed and without names altered.

## About variables and data:   
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `activity_labels` contains all the labels of six activities such as walking, sitting etc.\
* `features` contains the correct names for the `x_test` and `x_train` datasets. 
* `all_test` contains merged test data files;  `all_train` contains merged train data files
* `finaldataset` contains all test and train data files
* `setforMeanandStd` is subset of final dataset where only those measurements are extracted where mean and standard deviation for each measurement is present
* `setWithActivityNames` contains the dataset where descriptive activity names have been added using `activity_labels` file.
* `final_mean` contains mean of all the variables grouped by subject ID and activity ID.
*`tidy_data` contains the final data set which is ordered by subject ID and activity ID for ease of reading.
*`tidy_data.txt'`is the .txt file where the final tidy_data is written. 
* The layout of the text file is unwrapped so all the data can be seen by scrolling down rather than horizontally. I wasn't able to change this layout in my computer. 
