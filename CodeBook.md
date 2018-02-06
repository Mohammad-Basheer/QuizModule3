
CODE BOOK

#This code book details the construction of the code run_analysis.R.
#This contains the descriptions of the codes and variables used in this project.

#Before doing the script, make sure the data set is downloaded and saved in the directory you are currently working.

#Study Processes:

1. Import test and train data sets.
2. Load the train and test data sets.
4. Row bind both test and train dataset.
5. Extract only the measurements on the mean and standard deviation for each measurement
6. Replace activity IDs with the activity labels for readability. Match the activity numbers with appropriate activity names provided
7. Group the dataset based on subject IDs and activity
8. Calculate mean for the new dataset, saving under "Avedata"
9. Write the "Avedata" as "Avedata.txt" as final output

#Important data used:

features.txt - List of all features
activity_labels.txt - Links the class labels with their activity name
X_train.txt/y_train.txt/subject_train.txt - Training set
X_test.txt/y_test.txt/subject_test.txt - Test set

#Identifiers

Human Activity Recognition database built from the recordings of 30 volunteers (within an age bracket of 19-48 years) performing activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.

SubjectID - An identifier of the subject who carried out the experiment. It ranges from 1 to 30.
Activity - The activity type performed when the corresponding measurements were taken. Each person performed six activities:
WALKING - Subject was walking during the experiment
WALKING_UPSTAIRS - Subject was walking up a staircase during the experiment
WALKING_DOWNSTAIRS - Subject was walking down a staircase during the experiment
SITTING - Subject was sitting during the experiment
STANDING - Subject was standing during the experiment
LAYING - Subject was laying down during the experiment

#Source file is named run_analysis.R. The tidy dataset is saved as Avedata.txt.

#Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
          A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
          21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. 
          Bruges, Belgium 24-26 April 2013.
          
