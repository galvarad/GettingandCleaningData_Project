# Create a new directory to download files.
if(!file.exists("/Users/Gabriel/Documents/GettingandCleaningData/wearableData")){dir.create("/Users/Gabriel/Documents/GettingandCleaningData/wearableData")}
# Download and unzip the file.
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="/Users/Gabriel/Documents/GettingandCleaningData/wearableData/allData.zip", method="curl")
unzip(zipfile="/Users/Gabriel/Documents/GettingandCleaningData/wearableData/allData.zip", exdir="/Users/Gabriel/Documents/GettingandCleaningData/wearableData")
# Create a path for saving the files and load files into R workspace. 
path<-file.path("/Users/Gabriel/Documents/GettingandCleaningData/wearableData", "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files
activityTest<-read.table(file.path(path, "test", "y_test.txt"), header=FALSE)
activityTrain<-read.table(file.path(path, "train", "y_train.txt"), header=FALSE)
subjectTrain<-read.table(file.path(path, "train", "subject_train.txt"), header=FALSE)
subjectTest<-read.table(file.path(path, "test", "subject_test.txt"), header=FALSE)
featuresTest<-read.table(file.path(path, "test", "X_test.txt"), header=FALSE)
featuresTrain<-read.table(file.path(path, "train", "X_train.txt"), header=FALSE) 
featuresColNames<-read.table(file.path(path, "features.txt"), header=FALSE)
#1. Merge training and test data sets to create one data set named totalData.
featuresData<- rbind(featuresTrain, featuresTest)
subjectData<- rbind(subjectTrain, subjectTest)
activityData<- rbind(activityTrain, activityTest)
colnames(featuresData)<-featuresColNames[,2]
colnames(subjectData)<-"subject"
colnames(activityData)<-"activity"
combinedSubjectActivityData<-cbind(subjectData, activityData)
totalData<-cbind(featuresData, combinedSubjectActivityData)
#2. Extracts only the measurements on the mean and std for each measurement
# Take column names of features with "mean()" or "std()"
subsetfeaturesColNames<-featuresColNames$V2[grep("mean\\(\\)|std\\(\\)", featuresColNames$V2)]
# Subset the data frame totalData by selected column names of features
selectedColNames<-c(as.character(subsetfeaturesColNames), "subject", "activity")
totalData<-subset(totalData,select=selectedColNames)
#3. Use descriptive activity names to name activity 
# Read descriptive actiity names
activityNames <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
# Replace activity numbers with names
totalData$activity<-factor(totalData$activity, labels=activityNames[,2])
#4. Appropriately label the data set with descriptive variable names.
names(totalData)<-gsub("\\()","", names(totalData))
names(totalData)<-gsub("-std$","StdDev", names(totalData))
names(totalData)<-gsub("-std","StdDev", names(totalData))
names(totalData)<-gsub("-mean","Mean", names(totalData))
names(totalData)<-gsub("^(t)","time", names(totalData))
names(totalData)<-gsub("^(f)","frequency", names(totalData))
names(totalData)<-gsub("Acc","Accelerometer", names(totalData))
names(totalData)<-gsub("Gyro","Gyroscope", names(totalData))
names(totalData)<-gsub("Mag","Magnitude", names(totalData))
names(totalData)<-gsub("BodyBody","Body", names(totalData))
names(totalData)<-gsub("-","", names(totalData))
#check
names(totalData)
#5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
# Creates independent tidy data set by subject and activity. Then dcast takes the average of each variable for each activity and subject. 
readyData <- melt(totalData, id.vars = c("subject", "activity")) 
tidyData <- dcast(readyData, subject + activity ~ variable, mean)
# Export tidyData
write.table(tidyData, "tidyData.txt", row.name=FALSE)
