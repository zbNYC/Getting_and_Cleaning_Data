
library(reshape2)

###################################################################
## Step1: Merging the training and the test sets to create one data set.
###################################################################
	## The assumption is, all files which are to be merged, are in the working directory
	## Read data in the memory first
	Xtrain <- read.table("X_train.txt", header = FALSE)
  Xtest <- read.table("X_test.txt", header = FALSE)
  Ytrain <- read.table("y_train.txt", header = FALSE)
  Ytest <- read.table("y_test.txt", header = FALSE)
  SubjectTrain <- read.table("subject_train.txt", header = FALSE)
  SubjectTest <- read.table("subject_test.txt", header = FALSE)
  ## Merge data
  X <- rbind(Xtrain, Xtest)
  y <- rbind(Ytrain, Ytest)
  s <- rbind(SubjectTrain, SubjectTest)

#######################################################################  
## Step2: Extract only the measurements on the mean and standard deviation for each measurement
#######################################################################
	## Read label names from the features.txt
  features <- read.table("features.txt")
  ## Find index from the features table of the measurements which contain "-mean()" OR "-std()" in their label names
	feature_index <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])  
  ## Extract only those measurements from X whose columns are feature_index
	X <- X[, feature_index]
	##Add label name to each of the columns of X
	names(X) <- features[feature_index, 2]

########################################################################
## Step 3: Using descriptive activity names to name the activities in the data set
########################################################################
	## Read activity labels
 	activity_label <- read.table("activity_labels.txt") 
	
	## make the name of the activity "nicer", i.e. "WALKING_DOWNSTAIRS" becomes "Walking Downstairs"    
 	## replace the numeric value of the activity in "y" with the name of the activity (column 2) from the activity_label
 	y[,1] = gsub("\\b(\\w)", "\\U\\1", gsub("_", " ", tolower(activity_label[y[,1], 2])), perl=TRUE) 

 
######################################################################## 
## Step 4: Label appropriately the data set with descriptive variable names
##         Bind all three sets together
######################################################################## 
  names(y) <- "Activity"
  names(s) <- "Subject"
	names(X) <- gsub("-", ".", gsub("\\(|\\)", "", names(X))) # get rid of "(" or ")", replace dash with dot

  CombinedDataSet <- cbind(s, y, X)

##########################################################################
## Step 5: From the data set in the previous step, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.
##########################################################################
	# Use melt and dcast functions from reshape2 package to create tidy data 
	wide_data <- melt(CombinedDataSet, id=c("Subject","Activity")) 
 	tidy_data <- dcast(wide_data, Subject + Activity ~ variable, mean) 
 
 # write the tidy_data into the file 
 write.table(tidy_data, "tidy_data.txt", row.names=FALSE)
