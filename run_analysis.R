
#Setting destination path

pathdata = file.path("./Assignment 4", "UCI HAR Dataset")
files = list.files(pathdata, recursive=TRUE)

#Reading training tables - xtrain / ytrain, subject train
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
#Reading the testing tables
xtest = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
#Read the features data
features = read.table(file.path(pathdata, "features.txt"),header = FALSE)
#Read activity labels data
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)


#Create Sanity and Column Values to the Train Data
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"
#Create Sanity and column values to the test data
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"
#Create sanity check for the activity labels value
colnames(activityLabels) <- c('activityId','activityType')

# 1. Merging training and test dataset
#Merging the train and test data - important outcome of the project
mrg_train = cbind(ytrain, subject_train, xtrain)
mrg_test = cbind(ytest, subject_test, xtest)
#Create the main data table merging both table tables - this is the outcome of 1
setAllInOne = rbind(mrg_train, mrg_test)

#2. Extracting only the measurements on the mean and standard deviation for each measurement
# Need step is to read all the values that are available
colNames = colnames(setAllInOne)
#Need to get a subset of all the mean and standards and the correspondongin activityID and subjectID 
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#A subtset has to be created to get the required dataset
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]


# 3 Use descriptive activity names to name the activities in the data set
setWithActivityNames = merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)


# 4. Appropriately labels the data set with descriptive variable names

name1 <- names(setWithActivityNames)
 name1 <- names(setWithActivityNames)
 name1 <- sub("^t", "Time ", name1)
 name1 <- sub("^f", "FFT ", name1)
 name1 <- sub("BodyAcc", "Body Accelerometer ", name1)
 name1 <- sub("GravityAcc", "Gravity Accelerometer", name1)
 name1 <- sub("BodyGyro", "Body Gyro ", name1)
 name1 <- sub("BodyBody", "Body", name1)
 name1 <- sub("mean()", "Mean", name1)
 name1 <- sub("std()", "Standard Deviation", name1)
 name1 <- sub("activityType", "Activity Type", name1)
 name1 <- sub("activityID", "Activity ID", name1)
names(setWithActivityNames) <- name1

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# New tidy set has to be created 
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

#The last step is to write the ouput to a text file 
write.table(secTidySet, "Assign4TidySet.txt", row.name=FALSE)





