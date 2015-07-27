# Geting and Cleaning Data: Course Project

#Clean up WorkSpace
rm(list=ls())


#Assumes UCI HAR Dataset folder in current working directory
#If UCI HAR Dataset in a specific/different direcotry, set the following path
#setwd('/Users/JimM/Jims Data/Rfiles/RCourses/GCD_Project/UCI HAR Dataset')


#Read in the meta data  
varnames     = read.table('./features.txt',header=FALSE)            #contains 561 col/var names
activity     = read.table('./activity_labels.txt',header=FALSE)     #conatins 6 activity labels

# Assigin column names to activity meta data  
colnames(activity)  = c('activityId','activityName')

#Read in Training data (21 subjects)
subjectTrain = read.table('./train/subject_train.txt',header=FALSE) #contains subject key for 21 training subjects
yTrain       = read.table('./train/y_train.txt',header=FALSE)       #contains activity key for 6 activities
xTrain       = read.table('./train/x_train.txt',header=FALSE)       #contains actual training data - aligned with training

#Assign colnames to Training data
colnames(subjectTrain)  = "subjectId" 
colnames(yTrain)        = "activityId" 
colnames(xTrain)        =  varnames[,2] 
 
# Merge all training data together 
train = cbind(yTrain,subjectTrain,xTrain)

#Read Test data (9 subjects)
subjectTest = read.table('./test/subject_test.txt',header=FALSE)    #contains subject key for 9 test subjects
xTest       = read.table('./test/x_test.txt',header=FALSE)          #contains actual test data
yTest       = read.table('./test/y_test.txt',header=FALSE)          #contains activity key for 6 activities - aligned with test
 
#Assign colnames to Test data
colnames(subjectTest)  = "subjectId" 
colnames(xTest)        =  varnames[,2]  
colnames(yTest)        = "activityId"

# Merge all test data together 
test = cbind(yTest,subjectTest,xTest)

#Step 1: Merge Training and Test sets to create one data set
FData = rbind(train,test)

#Step 2: Extract only the measures of mean and standard deviation
FData2 =  FData[ ,  c("subjectId", "activityId",
          "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z",
          "tBodyAcc-std()-X",  "tBodyAcc-std()-Y",  "tBodyAcc-std()-Z",
          "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z",
          "tGravityAcc-std()-X", "tGravityAcc-std()-Y",  "tGravityAcc-std()-Z",
          "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z",
          "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z",
          "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z",
          "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z",
          "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z",
          "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z",
          "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()",
          "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()",
          "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()",
          "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y",
          "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y",
          "fBodyAcc-std()-Z", "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y",
          "fBodyAcc-meanFreq()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y",
          "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y",
          "fBodyAccJerk-std()-Z", "fBodyAccJerk-meanFreq()-X", "fBodyAccJerk-meanFreq()-Y",
          "fBodyAccJerk-meanFreq()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y",
          "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z",
          "fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y", "fBodyGyro-meanFreq()-Z",
          "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyGyroMag-mean()",
          "fBodyBodyGyroMag-std()", "fBodyBodyGyroMag-meanFreq()", "fBodyBodyGyroJerkMag-mean()",
          "fBodyBodyGyroJerkMag-std()", "fBodyBodyGyroJerkMag-meanFreq()", "angle(tBodyAccMean,gravity)",
          "angle(tBodyAccJerkMean),gravityMean)", "angle(tBodyGyroMean,gravityMean)",
          "angle(tBodyGyroJerkMean,gravityMean)", "angle(X,gravityMean)", "angle(Y,gravityMean)",
          "angle(Z,gravityMean)" )]

#Step 3: Use Descriptive Activity Names for the actitivies in the dataset
FData3 = merge(FData2,activity,by='activityId',all.x=TRUE)


#Step 4: Appropriatly label the data set with descriptive variable names
varNames2 = colnames(FData3);

for (i in 1:length(varNames2))  
   { 
     varNames2[i] = gsub("-std","StdDev",varNames2[i]) 
     varNames2[i] = gsub("-mean","Mean",varNames2[i]) 
     varNames2[i] = gsub("[-()]", "", varNames2[i]) 
}

colnames(FData3) = varNames2


#Step 5: Calcualte Mean of each variable by activity and subject

#Drop Activity Name
FData4 =  FData3[,names(FData3) != 'activityName']; 

aggdata   <-aggregate(FData4, by=list(FData3$activityId, FData3$subjectId), 
                      FUN=mean, na.rm=TRUE)

#Clean Up output from Agg function
aggdata =  aggdata[,names(aggdata) != c('Group.1', 'Group.2')]

#Merge ActivityNames back in
aggd2   = merge(aggdata,activity,by='activityId',all.x=TRUE)

#Reorder by Subject Id
FDtidydata <- aggd2[order(aggd2$subjectId, aggd2$activityId),]


#Write out final, tidydata set  
write.table(FDtidydata, './tidyData.txt',row.names=TRUE,sep='\t')





