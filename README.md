# QuizModule3

#Course Project
##This repository contains course project deliverable for the module 3 Getting and Cleaning Data.
A. Deliverables: 

1. README.md
Describes the repository content and describes how the script works

2. CodeBook.md
Describes the variables, the data, and transformations performed to clean up the data for this course project

3. run_analysis.R
R code for all the cleansing and trasformation work

4. Avedata.txt
Output for this course project

B. How the script works: In run_analysis.R, first it read all data sets and store into variables

trainData: Training set
trainLabel: Training label
trainSubject: Training subject
testData: Testing set
testLabel: Testing label
testSubject: Testing subject
features: List of all features
activity: Class labels with activity name

#Step 1 Merges the training and the test sets to create one data set
data.train: Combine all train data - trainData, trainLabel, trainSubject
data.test: Combine all test data - testData, testLabel, testSubject
data.all: Combine data.train, data.test

#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement
cols: Read the columns that has mean or standard deviation in measurement
data.mean_std: Subset data.all, and only keep columns defined in cols

#Step 3 Uses descriptive activity names to name the activities in the data set
colname: Uses activity name as column name for data.mean_std

#Step 4 Appropriately labels the data set with descriptive variable names
data.merge: Merge data.mean_std and activity by 'ActivityName'

#Step 5 Creates a second, independent tidy data set
Avedata: Use data.table package to process data.merge, calculate the average of each variable for each activity and each subject, and 
write it into text file
