
setwd("C:/Users/Asger/OneDrive/Training/Coursera/03 Getting and Cleaning Data")

# It is asumed the zipfile has been downloaded to the data subdirectory to the current working directory

# The reshape2 package is used later on

if (!require("reshape2")) {
   install.packages("reshape2")
   require("reshape2")
}

# Read the data from the test set
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_activity_id <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# Read the data from the train set
train_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_activity_id <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
 
# Merge data
# I have elected to merge the data first and do the cleanup on the merged data. 
# The cost of this is slightly longer runtime
# The upside is the code is more readable
merged_data <- rbind(test_data,train_data)
merged_subject <- rbind(test_subject,train_subject)
merged_activity_id <- rbind(test_activity_id, train_activity_id)

# Read the feature names and activity labels from the relevant txt-files
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
feature_names <- features[,2]
activity_names <- activity_labels[,2]

# Assign proper column names from feature_names
# Remove columns which does not contain "-mean", or "-std" from the merged data set.
names(merged_data) <- feature_names
merged_data <- merged_data[,grepl("-mean|-std", feature_names)]

# create a vector with the activity name instead of activity id.
activity <- activity_names[merged_activity_id[,1]]

# Add a column name to the merged subject array
colnames(merged_subject) <- "subject_id"

final_data <- cbind(merged_subject, activity, merged_data)

non_data_labels <- c("subject_id", "activity")
data_labels <- setdiff(colnames(final_data), non_data_labels)

melted <- melt(final_data, id = non_data_labels, measure.vars = data_labels)

summary <- dcast(melted, subject_id + activity ~ variable, mean)

write.table(summary, "./data/tidydata.txt", row.name=FALSE)

