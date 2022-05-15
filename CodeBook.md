---
title: "CodeBook.md"
author: "me"
date: "5/14/2022"
output: html_document
---



# CodeBook

The run_analysis.R script performs the data download, and preparation as required by the assignment.

## The data source

* File URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Dataset downloaded and extracted under the folder called UCI HAR Dataset

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the  labels with their corresponding activity .

- 'train/X_train.txt': Training data.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test data.

- 'test/y_test.txt': Test labels.

## Data cleaning

5 steps:

1. Training and the test sets are merged with rbind().

2. Extracts only the measurements on the mean and standard deviation for each measurement.
  mean_sd_extraction is created with select() and contains() functions

3. Uses descriptive activity names to name the activities in the data set
  The codes are replaced with the corresponding activity from teh second column of  activity_labels 
  
  
4. Appropriately labels the data set with descriptive activity names.

label  column in mean_sd_extraction renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time


5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

StudyData  was created by sumarizing mean_sd_extraction calculating the means of each variable for each activity and each subject, after grouping by subject and activity.
StudyData was written into TidyStudyData.txt file.