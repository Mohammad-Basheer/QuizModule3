# load column feature names
feature <- read.table("features.txt")

# import test data
test <- read.table("./test/X_test.txt",col.names = feature[,2])
test_label <- read.table("./test/y_test.txt", col.names = "activity")
# load subject names
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")

# combine data
test<- cbind(subject_test, test_label, test)

# import train data
train <- read.table("./train/X_train.txt",col.names = feature[,2])
train_label <- read.table("./train/y_train.txt", col.names = "activity")
# load subject names
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")

# combine data
train<- cbind(subject_train, train_label, train)

rm("test_label","train_label", "subject_test", "subject_train")


# 1) Merge test and train data

data <- rbind(test, train)

rm("train","test")

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.

# load dplyr package
library(dplyr)

# select only mean and std in the dataset
select <- grep(("mean|std"), tolower(feature[,2]))+2
data_select <- select(data, subject, activity, select)

rm("feature","data","select")


# 3) Uses descriptive activity names to name the activities in the data set

# load activity label
activity_label <- read.table("activity_labels.txt")

# change the activity code into activity labels
data_select$activity <- factor(data_select$activity, levels = activity_label[,1], labels = activity_label[,2]) 
rm("activity_label")


# 4) Appropriately labels the data set with descriptive variable names
# variable names were already edited in step 0) when importing data

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# group data into groups, according to activity
data_select <- group_by(data_select, subject, activity)
data_select %>% summarize_each(funs(mean(., na.rm=TRUE))) -> result 

# write result into "Avedata.txt"
write.table(result, "Avedata.txt", row.names = FALSE, quote = FALSE)