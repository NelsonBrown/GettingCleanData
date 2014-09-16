---
title: "CodeBook"
author: "Nelson Brown"
date: "Tuesday, September 16, 2014"
output: html_document
---

This is the codebook that provides the description of the course project, the source of the data, the data descriptions and the operations performed on the data to arrive with the resulting measurement data set.

The original data source was from an experiment conducted by;

        Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
        Smartlab - Non Linear Complex Systems Laboratory
        DITEN - Università degli Studi di Genova.
        Via Opera Pia 11A, I-16145, Genoa, Italy.
        activityrecognition@smartlab.ws
        www.smartlab.ws
        
Titled:

        Human Activity Recognition Using Smartphones Dataset
        Version 1.0

The following zip file was downloaded and unzipped to a directory named "C:\\Coursera\\data\\UCI HAR Dataset".

        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
        
A full description of the experiment can be found at:

        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
        
The R program used to create these datasets is run_analysis.R. It is located in the "C:\\Coursera\\R" directory.        
        
The UCI HAR Dataset directory contains multiple files and directories.

The directories are test and train. These subdirectories contain the data resulting from the two parts of the experiment, testing and training.

        Test contains 2947 observations in three files; 
        
                        subject_test.txt identifies the subject being measured. 
                        
                                30 subjects aged 19-48 years.
                        
                        x_test.txt contains 561 different measures.
                        
                        y_test identifies the activity being measured.
                        
                                1 WALKING
                                2 WALKING_UPSTAIRS
                                3 WALKING_DOWNSTAIRS
                                4 SITTING
                                5 STANDING
                                6 LAYING

        Train contains 7,352 observations in three files; 
        
                        subject_train.txt identifies the subject being measured. 
                        
                                30 subjects aged 19-48 years.
                        
                        x_train.txt contains 561 different measures.
                        
                        y_train identifies the activity being measured.
                        
                                1 WALKING
                                2 WALKING_UPSTAIRS
                                3 WALKING_DOWNSTAIRS
                                4 SITTING
                                5 STANDING
                                6 LAYING
                                
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

validMeasures <- grep("-mean\\(|-std\\(",features[,2]).

validMeasures was then used to subset the measurement observation data.

measures <- measures[, validMeasures]

Once the observations have been trimmed to the relevant measures the subject and activity are joined to the measurement data and the column names replaced with the measurement descriptions from features.txt minus the "(", ")" characters.
        
                        
                        