## Getting and Cleaning Data - course project
In this repository you'll find the required files for completing the course project

1) the analysis.R script

2) The Codebook

3) This Readme file

The script requires the reshape2 package

The task was to create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The steps in the script are:

1. Read the data from the test folder
2. Read the data form the train folder
3. Merge the data
4. Read the feature names and activity labels from the txt-files
5. Assign proper column names to the merged data, and eliminate columns which doesn't contain -mean og -std in the column name
6. The subject id (test person) and the activity label are merged together with the "main" data
7. Finally, in two steps the data are first melted and then summarised to form a table witl 180 rows(30 persons, 6 activities) and a total of 81 variables

I decided to merge the data before cleaning up the unwanted rows. This is a bit slower, but makes the code more readable.

To execute the script properly, the zip-file should be downloaded to a subfolder to the current wd named "data". 
