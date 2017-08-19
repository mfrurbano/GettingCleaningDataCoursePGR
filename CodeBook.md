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
After this only columns representing mean and stddev were selected.
Everything else was dropped so we ended up with 79 variables.

The main observation files needed to be complemented with columns regarding:
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

To obtain the statistics grouped by subject-activity, a grouped data frame was created and summarise_all function was
executed. The resulting frame was then saved with no row names as requested.

Column names for the data set are provided in names_tidy.txt file.

