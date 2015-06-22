## Project Codebook

## The Project goal
In this project, the raw data will be transformed into tidy data, which can be used for later analysis.


### Data sets - background information
The data used for the project, contained in the zip file, are dowloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The main source of data, as well as the supporting documentation, can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The dataset includes the following files:
-'README.txt'
-'features_info.txt': Shows information about the variables used on the feature vector.
-'features.txt': List of all features.
-'activity_labels.txt': Links the class labels with their activity name.
-'train/X_train.txt': Training set.
-'train/y_train.txt': Training labels.
-'test/X_test.txt': Test set.
-'test/y_test.txt': Test labels.
-'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
-'test/subject_test.txt': the same description as for 'train/subject_train.txt'


### Description of the Variables
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label
- An identifier of the subject who carried out the experiment.


### Creation of the tidy data set - the R script run_analysis.R steps
The R script utilizes the package reshape2, which needs to be installed and loaded, as it does not come in the base R installation.
- The first step is to load training and test data (Training & Test set (X) / Training & Test labels (y) / Training & Test subject (s))  into memory, and then merge those training and test data, i.e. row binding: X <- rbind(Xtrain, Xtest))
- The merged Training & Test set (X) contains 561 columns, whose lebels (name of the feature that is measured) are provided in the features.txt file. The project requirement is to extract only measurements on the mean and standard deviation, which is achived by finding the index of the labels in the vector features which contain "-mean()" OR "-std()" in their names, and then extract only those measurements to X (Data set), and assigning the those label names to X.
- The next step is to use the descriptive activity names to name the activities in the data set. First, the activity_labels.txt is loaded, and the name of each activity replaced by "nicer" name, i.e. "WALKING_DOWNSTAIRS" becomes "Walking Downstairs". The numeric values in the merged Traing and Test labels (y) is replaced by activity labels.
- The fourth step is to label appropriately the data set with descriptive variable names, and column bind Subject, Activity, X (merged Training & Test). The result is a data frame which has in the the first column contains the Subject, in the second column Activity names, and the following 66 columns are measurements. This data frame is a basis for the creation of the tidy data set, which is done in the last step of the script.
- The independent tidy data set is created with the average of each variable for each activity and each subject. The melt and dcast functions from the reshape2 package are used to create wide tidy data set, which is written to the file "tidy_data.txt". As there are 6 activities and 30 subjects, there are total of 180 rows in this data set with averages.

