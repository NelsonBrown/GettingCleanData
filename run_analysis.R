# set the working directory

setwd("c:\\coursera\\data\\UCI HAR Dataset")

# Read the test.txt and train.txt files into memory

xtrain <- read.table(".\\train\\x_train.txt")
xtest <- read.table(".\\test\\x_test.txt")

# Combine the measures

measures <- rbind(xtrain, xtest)

# Read the features.txt file for the measurement names

features <- read.table(".\\features.txt")

validMeasures <- grep("-mean\\(|-std\\(",features[,2]) # Have to look for the "(" character to make sure we are at the end of the line

measures <- measures[, validMeasures]

# Add the names to the data set

names(measures) <- features[validMeasures,2]

# Remove the ()'s

names(measures) <- gsub("\\(\\)","",names(measures))

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

# Merge the files

tidyData <- cbind(subjects, activities, measures)

# Write out the tidy data file

write.table(tidyData, "c:\\coursera\\R\\merged_clean_data.txt")