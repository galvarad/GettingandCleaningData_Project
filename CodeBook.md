#Description
Additional information about the data, the variables, and any transformations used to clean up the wearable computing data. 

##Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
##Variables
* activityTest, activityTrain, subjectTest, subjectTrain, featuresTrain and featuresTest contain the data from the downloaded files
* activityData, subjectData, and featuresData merge the data sets above by row binding the Test and Train data. 
* featuresColNames contains the names for the featuresData
* subsetFeaturesColNames takes column names with "mean()" or "std()" form featuresColNames data set
* totalData represents a data frame created by column binding the activityData, subjectData, and featuresData
* activityNames, data set that contains the string description of the activity and its corresponding id. 
* readyData, an independent dataset organized my subject and activity. Subset of totalData
* tidyData, dataset that contains the average of each variable organized by subject and activity

##Transformations
0. Creates a new directory to download the file. Download and unzips the files to use in project
1. Merges the training and the test sets to create one data set.This is done by first row binding the test and train data for each x, y and subject. The names of these data sets are then added. The three separate data sets can then be colbind to creat the data frame totalData. 
2. Extracts only the measurements on the mean and std for each measurement. This is done by taking the column names of features with "mean()" and "std()" and subsetting the data fram totalData by these column names. 
3. Use descriptive activity names to name activity. Read the descriptive activity names and then replace the activity numbers with the names. 
4. Appropriately label the data set with descriptive variable names. Use gsub to change variable names to reflect tidy data principles. 
5. Melt creates independent tidy data set by subject and activity. Then dcast takes the average of each variable for each activity and subject.
