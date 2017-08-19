# GettingCleaningDataCoursePGR


Getting and Cleaning Data Science Course - Peer Graded Review Project


Script Explanation:

1 - To perform the assigned task I´ve resorted to 2 expansion packages:
	- data.table
	- dplyr
    They were loaded immediately after initial env cleaning and wd setup:
	## Loading libraries
	library(data.table)
	library(dplyr)

2 - Next step was reading the main observation data files
	## Reading main data files
	dtTrain <- read.table("./train/X_train.txt")
	dtTest <- read.table("./test/X_test.txt")

3 - As the files had no column titles, let´s get them and name
	## Reading feature (main files column names)
	feat <- read.table("./features.txt",stringsAsFactors = FALSE)
	## Naming main files columns
	names(dtTrain) <- feat$V2
	names(dtTest) <- feat$V2

4 - Subject identifications are in separate files (one for train, one for test)
    We will now read them and attribute a good column name
	## Reading subject data and attributing a clear column name
	dtSubjTrain <- read.table("./train/subject_train.txt",stringsAsFactors = FALSE)
	names(dtSubjTrain) <- "subject"
	dtSubjTest <- read.table("./test/subject_test.txt",stringsAsFactors = FALSE)
	names(dtSubjTest) <- "subject"

5 - Activities descriptions will be needed => read and name the column
	## Reading activity descriptions and attributing a clear column name
	activity <- read.table("./activity_labels.txt",stringsAsFactors = FALSE)
	names(activity)[2] <- "activityDesc"

6 - Activity identification is also apart of main data files => reading files now
	## Reading activity code files
	dtTrainLabels <- read.table("./train/y_train.txt",stringsAsFactors = FALSE)
	dtTestLabels <- read.table("./test/y_test.txt",stringsAsFactors = FALSE)

7 - Now the separate columns will be added to the main files
	## Binding columns to main files
	##
	## First subject column
	dtTrain <- cbind(dtSubjTrain,dtTrain)
	dtTest <- cbind(dtSubjTest,dtTest)
	## Now, activity code
	dtTrain <- cbind(dtTrainLabels,dtTrain)
	dtTest <- cbind(dtTestLabels,dtTest)

8 - Train and test observations are requested to be joined
	## Joining the main files for train and test
	dtJoin <- rbind(dtTrain,dtTest)

9 - The activities are represented by codes that must be changed into descriptions
    By merging the activity description table we will insert this information
    The column V1 - activity code - exists in both sides and will do the magic
    After merging it can be dropped
	## Merging activity codes to the joined file
	##    - merging column was not passed since it has the same name,
	##    - V1, in both files
	dtJoin <- merge(activity,dtJoin)
	##
	## Join column V1 was very useful but now can be dropped
	dtJoin <- select(dtJoin, -V1)

10 - A frame with global mean and sd for each variable is requested
     We will do this by creating a vector with each statistic and joining them in a frame
	## Generating the table with only the global statistics
	##
	## First creating 2 vectors, one for each statistic
	means <- sapply(dtJoin[,3:563],mean)
	sds <- sapply(dtJoin[,3:563],sd)
	## Now joining the 2 and getting the desired table
	measureStats <- data.frame(means,sds)
	## Better names pay off!
	names(measureStats) <- c("mean","std dev")

11 - To have statistics for groups of subject-activity we need to ... group them
     A new grouped frame is to be created
	## Creating a grouped frame for the remaining steps
	dtJoinG <- group_by( dtJoin, .dots = c("subject", "activityDesc"))

12 - Now we can apply summarise to create the statistics table
     In the sequence we write a file as specified
	## Summarising as requested and getting a tidy data frame
	tidy <- summarise_all(dtJoinG, funs(mean))
	## Generating the tidy data set file
	write.table(tidy,file="tidy.txt",row.names=FALSE)



