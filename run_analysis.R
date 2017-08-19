## Cleaning up
rm(list=ls())

## Changing working directory to the one where data was extracted 
setwd("C:/Users/Marcelo/Downloads/UCI HAR Dataset")

## Loading library
library(data.table)
library(dplyr)

## Reading main data files
dtTrain <- read.table("./train/X_train.txt")
dtTest <- read.table("./test/X_test.txt")

## Reading feature (main files column names)
feat <- read.table("./features.txt",stringsAsFactors = FALSE)

## Naming main file columns
names(dtTrain) <- feat$V2
names(dtTest) <- feat$V2

## Selecting only variables on mean and std
varSelect <- grepl(".*mean.*|.*std.*",feat$V2)
dtTrain <-dtTrain[varSelect]
dtTest <- dtTest[varSelect]

## Reading subject data and attributing column names
dtSubjTrain <- read.table("./train/subject_train.txt",stringsAsFactors = FALSE)
names(dtSubjTrain) <- "subject"
dtSubjTest <- read.table("./test/subject_test.txt",stringsAsFactors = FALSE)
names(dtSubjTest) <- "subject"

## Reading activity descriptions and attributing a clear column name
activity <- read.table("./activity_labels.txt",stringsAsFactors = FALSE)
names(activity)[2] <- "activityDesc"

## Reading activity code files
dtTrainLabels <- read.table("./train/y_train.txt",stringsAsFactors = FALSE)
dtTestLabels <- read.table("./test/y_test.txt",stringsAsFactors = FALSE)

## Binding activity and subject columns to main files
dtTrain <- cbind(dtTrainLabels,dtSubjTrain,dtTrain)
dtTest <- cbind(dtTestLabels,dtSubjTest,dtTest)

## Joining the main files for train and test
dtJoin <- rbind(dtTrain,dtTest)

## Merging activity codes to the joined file
##	- joining column was not passed since it has the same name,
##    - V1, in both files
dtJoin <- merge(activity,dtJoin)

## Join column V1 was very useful but now can be dropped
dtJoin <- select(dtJoin, -V1)

## Creating a grouped frame for the remaining steps
dtJoinG <- group_by( dtJoin, .dots = c("subject", "activityDesc"))

## Summarising as requested and getting a tidy data set
tidy <- summarise_all(dtJoinG, funs(mean))

## Generating the tidy data set file
write.table(tidy,file="tidy.txt",row.names=FALSE)



