GettingCleanData
================

Repository for Course Project of Getting and Cleaning Data


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

Once the observations have been trimmed to the relevant measures the subject and activity are joined to the measurement data and the column names replaced with the measurement descriptions from features.txt minus the "(", ")" characters. The following image documents graphically what is taking place. 
                        

![alt text](Slide2.png)


This image was provided by David Hood Community TA with Coursera.


Next we read the file containing the activity number and description.

# Read the activity files into memory

ytrain <- read.table(".\\train\\y_train.txt")
ytest <- read.table(".\\test\\y_test.txt")

# Combine the acivities

activities <- rbind(ytrain, ytest)

# Read the activity descriptions

activity <- read.table("activity_labels.txt")

activity

  V1                 V2
1  1            WALKING
2  2   WALKING_UPSTAIRS
3  3 WALKING_DOWNSTAIRS
4  4            SITTING
5  5           STANDING
6  6             LAYING

Here we add the activity description to the table of activities by observation

activities [,1] = activity[activities[,1], 2]

names(activities) <- "activity"

> head (activities)
  activity
1 STANDING
2 STANDING
3 STANDING
4 STANDING
5 STANDING
6 STANDING
 
> tail (activities)
              activity
10294 WALKING_UPSTAIRS
10295 WALKING_UPSTAIRS
10296 WALKING_UPSTAIRS
10297 WALKING_UPSTAIRS
10298 WALKING_UPSTAIRS
10299 WALKING_UPSTAIRS


Now we need to create a data table of the subject identity by observation

# Read the Subject files into memory

strain <- read.table(".\\train\\subject_train.txt")
stest <- read.table(".\\test\\subject_test.txt")

subjects <- rbind(strain, stest)

# name the subject table column

names(subjects) <- "subject"

# Merge the files

tidyData <- cbind(subjects, activities, measures)

# Write out the tidy data file

write.table(tidyData, "c:\\coursera\\R\\RunAnalysisDataFile1.txt")

# Create data set of averages of each activity by each participant

library(plyr)

averages <- ddply(tidyData, c("subject", "activity"), numcolwise(mean))

write.table (averages, "c:\\coursera\\data\\RunAnalysisaverage.txt",row.name=FALSE)

Upload the average file and we are finished.
