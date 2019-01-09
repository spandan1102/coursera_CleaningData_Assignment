Following is the process which is followed to complete all the objectives and create a file. Please note that the objectives are not achieved as listed. Instead, all the objectives are achieved as and when it is suitable for coding.This is how the script works:

STEP1: Zip file is downloaded and unzipped manually
STEP2: Location of the files is defined using file.path function
STEP3: 3 train data files are read: x_train, y_train & subject_train
STEP5: Similarly, test data set is read
STEP6: Featues and activity_level data is also read
STEP7: Column of x-train, y_train and Subject_train are named for easy reading (part of objective 4)
STEP8: Similarly, columns test data and activity_label dataset are also named. (Objective 4 is complete)
STEP9: Merging of test and train data together is achieved using rbind function (Objective 1 is complete)
STEP10:Using the grepl function to get the data and create a data set which only contains the mean and standard deviation for each measurements (Objective 2 complete)
STEP11: We will merge the above file with the activityLabels file keeping activityId as primary column. This will fill the descriptive details of the activities permormed in the "Activity Type" column. (Objective 3 is complete)
STEP12: Using aggregate function, an independent tidy data set is created which contains the average of each variable for each activity and each subject. (objective 5 is completes)
STEP13: The data is written in the file using write.table.

