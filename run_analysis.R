#Set directory

getwd()
setwd("C:/Users/Dell/ExamData")

#Create a folder

if(!file.exists("New")){
  dir.create("New")
}

#Step 1: Merge the test and the train data sets to create one data set

## Merge the test and the train data sets to create one data set
## Reading the test and the train data sets
list.files("./train")
trainDS <- read.table("./train/X_train.txt")

## Row bind both data sets
NewDS <- rbind(trainDS, testDS)

#Step 2: Extract only the measurements on the mean and standard deviation for each measurement
## Extract only the measurements on the mean and standard deviation for each measurement
## Get all the features
featuresDS <- read.table("./features.txt", stringsAsFactor=F)
colnames(featuresDS) <- c("id", "feature")

#Step 3: Getting measurements based on Mean and Standard deviation by feature names
## Getting measurements on Mean and Standard deviation by feature names
featuresMSD <- featuresDS[(grepl("mean()", featuresDS$feature, fixed = TRUE) | grepl("std()", featuresDS$feature, fixed = TRUE)), ]
iCnt <- nrow(featuresMSD)

## Extract Mean and Standard deviation from merged data set (mergeDS)
mergeMSD <- NewDS[, featuresMSD$id]

## Set new names
colnames(mergeMSD) <- featuresMSD$feature

## Adding subject id to each row
subjectTrainDS <- read.table("./train/subject_train.txt")
subjectTestDS <- read.table("./test/subject_test.txt")
mergeMSD$subject <- rbind(subjectTrainDS, subjectTestDS)$V1

#Step 4: Use descriptive activity names to name the activities in the data set
## Use descriptive activity names to name the activities in the data set

## Assigning activity labels to each row
activityTrainDS <- read.table("./train/y_train.txt")
activityTestDS <- read.table("./test/y_test.txt")
mergeMSD$label <- rbind(activityTrainDS, activityTestDS)$V1

## Match the activity numbers with appropriate activity names provided

## Read in activity labels
activityNamesDS <- read.table("./activity_labels.txt")

## Merge the two data sets to get the label names
mergeMSD <- merge(mergeMSD, activityNamesDS, by.x="label", by.y="V1", all = TRUE)

## Remove label number field and rename new field
mergeMSD$label <- NULL
colnames(mergeMSD)[68] <- "activitylabels"

### Refine factor level names
levels(mergeMSD$activitylabels) <- tolower(levels(mergeMSD$activitylabels))
levels(mergeMSD$activitylabels) <- sub("_", "", levels(mergeMSD$activitylabels))

## Sort the dataset by subject id and then by activity name
mergeMSD <- mergeMSD[order(mergeMSD$subject, mergeMSD$activitylabels), ]

#Step 5: Appropriately label the data set with descriptive column names

## Appropriately label the data set with descriptive column names
## print(colnames(mergeMSD))
source("assignNames.R")
colnames(mergeMSD) <- assignNames(colnames(mergeMSD))

## Create a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
Avedata <- mergeMSD
Avedata$activitylabels <- as.character(Avedata$activitylabels)

## Group the observations by subject and activity (180 groups = 30 subjects * 6 activities)
Avedata$group <- paste(Avedata$subject, Avedata$activitylabels)
Avedata$group <- as.factor(Avedata$group)

## Create the final Avedata data frame
finalAvedata=data.frame(1:180)

## Iteratively add each feature/field to the data frame
## iCnt is the number of features
for (i in 1:iCnt) {
  finalAvedata[, colnames(Avedata)[i]] <- tapply(Avedata[, i], Avedata$group, mean)
}

## Rename each row to corresponding group name
rownames(finalAvedata) <- unique(Avedata$group)

## Removing NULL
finalAvedata[, 1] <- NULL

## Write the tidy set into text file
write.table(finalAvedata, file="./New/Avedata.txt", sep="\t")