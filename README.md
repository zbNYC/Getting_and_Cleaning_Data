## Getting and Cleaning Data

### Course Project

In this project, the R script is developed to create a tidy data set from the raw data.
The tidy data (Hadley, 2004) satisfy the following requirements:
* Each variable forms a column
* Each observation forms a row
* Each type of observational unit forms a table

The R script does the following: 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names 
* From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Execution steps:
* Download the data source from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, unzip the files, and put the following files in the R working directory:  
    - X_test.txt
    - X_train.txt
    - y_test.txt
    - y_train.txt
    - subject_test.txt
    - subject_train.txt
    - activity_labels.txt
    - features.txt
    - features_info.txt
* The script run_analysis.R needs to be in the working directory
* Run source("run_analysis.R"). The result is the creation of the file tidy_data.csv in the R working directory.

Please note, the script run_analysis.R is using reshape2 package (http://cran.r-project.org/web/packages/reshape2/index.html) 

More about the data and the analysis can be found in the Codebook document.


References: Hadley, W., Journal of Statistical Software, August 2014, Volume 59, Issue 10.
