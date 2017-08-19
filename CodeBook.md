# 
Getting and Cleaning Data Science Course - Peer Graded Review Project


To perform the analysis we have used the data available in UCI Machine Learning Repository.

A detailed description of original data is available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself was downloaded at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Each observation file presented 561 variables. Files were at:
- train/x_train.txt
- test/x_test.txt

Columns were not named. Names were got from ./features.txt file and attributed.

In the analysis the main observation files needed to be complemented with columns regarding:
- subject
- type of activity

These informations were provided in separate files and were added through column binding.
File names were:
- subject
  - ./train/subject_train.txt
  - ./test/subject_test.txt
- activity
  - ./train/y_train.txt
  - ./test/y_test.txt

As activities where informed in non-descriptive numeric codes (1 to 6), a merge with a table
containing corresponding descriptions was required. After that, activity code column was dropped.
Table was loaded with contents of ./activity_labels.txt file.

The 2 remaining added columns where named as "subject" and "activityDesc", and appear before the variables.

To generate the frame with mean and sd for each variable, sapply was executed 2 times, each one
generating a vector with one line for each variable for one statistic. The 2 vectors were the binded to generate a data frame.
The names of the statistic columns were set as "mean" and "std dev".

To obtain the statistics grouped by subject-activity, a grouped data frame was created and summarise_all function was
executed. The resulting frame was then saved with no column titles as requested.

