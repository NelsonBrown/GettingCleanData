---
title: "CodeBook"
author: "Nelson Brown"
date: "Tuesday, September 16, 2014"
output: html_document
---

The original data source was downloaded from:

( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

This zip file was unzipped to the "c:\\coursera\data\\" directory

Data Set Information:

Measurements were taken for a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 



The R program used to create these datasets is run_analysis.R. It is located in the "C:\\Coursera\\R" directory.        
        
The UCI HAR Dataset directory contains multiple files and directories.

The directories are test and train. These subdirectories contain the data resulting from the two parts of the experiment, testing and training.  

The test directory contains 2947 observations in three files; 
        subject_test.txt identifies the subject being measured.   
        x_test.txt contains 561 different measures times 2947 = 1,653,267 measures.  
        y_test identifies the activity being measured.  
                1 identifies WALKING  
                2 identifies WALKING_UPSTAIRS  
                3 identifies WALKING_DOWNSTAIRS
                4 identifies SITTING
                5 identifies STANDING
                6 identifies LAYING

The train directory contains 7,352 observations in three files; 
        subject_train.txt identifies the subject being measured. 
        x_train.txt contains 561 different measures times 7352 = 4,124,472 measures.
        y_train identifies the activity being measured.
                        
                1 identifies WALKING  
                2 identifies WALKING_UPSTAIRS  
                3 identifies WALKING_DOWNSTAIRS
                4 identifies SITTING
                5 identifies STANDING
                6 identifies LAYING
                                
The x_test.txt and x_train.txt files were read into memory and combined using the rbind function resulting in a 10299x561 data frame.

This project is only interested in the measurements of mean and standard deviation.

The measurement descriptions are contained in a file named features.txt in the C:\\Coursera\\data\\UCI HAR Dataset\ directory.

features <- read.table("C:\\Coursera\\data\\UCI HAR Dataset\\features.txt")
> head(features)
  V1                V2
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z

In order to subset the observation data we used the grep function to identify those measurements of mean and std (standard deviation). 

validMeasures <- grep("-mean\\(|-std\\(",features[,2]) which returned 66 measures.

validMeasures was then used to subset the measurement observation data.

measures <- measures[, validMeasures] giving us a 10299x66 data frame 

The validMeasures was then used to subset the features data frame to retrieve the names of the 66 desired measurements.

names(measures) <- features[validMeasures,2]

These are used to name the measures columns minus the parenthesis.

names(measures) <- gsub("\\(\\)","",names(measures))

subject and activity are joined to the measurement data   

# Read the activity files into memory

ytrain <- read.table(".\\train\\y_train.txt")
ytest <- read.table(".\\test\\y_test.txt")

# Combine the acivities

activities <- rbind(ytrain, ytest)

# Read the activity descriptions

activity <- read.table("activity_labels.txt")

activities [,1] = activity[activities[,1], 2]

names(activities) <- "activity"

# Read the Subject file into memory

strain <- read.table(".\\train\\subject_train.txt")
stest <- read.table(".\\test\\subject_test.txt")

subjects <- rbind(strain, stest)

# name the subject table column

names(subjects) <- "subject"

# Merge the files to create the tidyData data frame

tidyData <- cbind(subjects, activities, measures)

  # Write out the tidy data file

write.table(tidyData, "c:\\coursera\\R\\RunAnalysisDataFile1.txt")

# Create data set of averages of each activity by each participant

library(plyr)

averages <- ddply(tidyData, c("subject", "activity"), numcolwise(mean))

  # Write out the averages data file

write.table (averages, "c:\\coursera\\data\\RunAnalysisaverage.txt",row.name=FALSE)                      
                        