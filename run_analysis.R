getwd()
setwd("C:/Users/Dell/ExamData")

#1.Merging training and the test sets into one data set.
####Loading training data set:
x_train <- read.table("./train/X-train.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
s_train <- read.table("./train/subject_train.txt", header = FALSE)

####Loading test data set:

x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
s_test <- read.table("./test/subject_test.txt", header = FALSE)

####Loading ExamFeatures into R:
ExamFeatures <- read.table ("features.txt", header = FALSE)

####Assign Column names to the data sets:
colnames(x_train) <- ExamFeatures$V2
colnames(x_test) <- ExamFeatures$V2
colnames(y_train) <- "Label"
colnames(y_test) <- "Label"
colnames(s_train) <- "Subject"
colnames(s_test) <- "Subject"

####Column-combine the training data set:
Train <- cbind(s_train, y_train, x_train)
Test <- cbind(s_test, y_test, x_test)

####Remove Columns with duplicates:
Train <- train [, !duplicated(colnames(train))]
Test <- test [, !duplicated(colnames(test))]

####Load dplyr
library(dplyr)
Train <- mutate(Train, datatype = "Train")
Test <- mutate (Test, datatype = "Test")

####combine the rows in the training dataset:
AllData <- rbind(Train, Test)

#2. Extract only the measurements on the mean and standard deviation for each measurement:

MeanSTD <- select (AllData, datatype, subject, label, contains("mean"), contains ("std"))

#3. Use descriptive activity names to name the activities in the data set:

Labels <- read.table("activity_labels.txt", header = FALSE)

MeanSTD$label <- factor (MeanSTD$label, levels = c(1,2,3,4,5,6))
Labels <- c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")

#4. Appropriately label the data set with descriptive names:
###Make the following change to the variable names:

####tBody     time-Body
####tGravity  time-Gravity
####Mag       Magnitude
####Gyro      Gyroscope
####Acc       Accelerometer
####fBody     fastFourierTransform_Body
####Freq      Frequency
####BodyBody  Body

nmeanstd <- gsub ("tBody", "time-Body", names(MeanSTD), ignore.case=FALSE)
nmeanstd <- gsub ("tGravity", "time-Gravity", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("Mag", "Magnitude", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("Gyro", "Gyroscope", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("Acc", "Accelerometer", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("fBody", "fastFourierTransform-Body", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("Freq", "Frequency", nmeanstd, ignore.case=FALSE)
nmeanstd <- gsub ("BodyBody", "Body", nmeanstd, ignore.case=FALSE)

colnames(MeanSTD) <- nmeanstd

#5. Create a second, independent tidy data set with the average of each variable for each activity and subject.

AveData <- MeanSTD %>%
  select (-datatype) %>%
  group_by(subject, label) %>%
  summarise_each(funs(mean))%>%
  print


write.table(AveData, file = "AveData.txt", row.names = FALSE, col.names = TRUE)
