

setwd("~/Desktop/Training/Data Science-Coursera/3 Getting and Cleaning Data/Week 4 Editing Text Variables/8 Course Project/UCI HAR Dataset")

library(dplyr)

# 1.Merges the training and the test sets to create one data set.

# Readind training and testing tables

x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/Y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/Y_test.txt")
subject_test<-read.table("./test/subject_test.txt")


x_train <- read.table("./train/X_train.txt", col.names = features$functions)
y_train <- read.table("./train/y_train.txt", col.names = "code")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")


x_test <- read.table("./test/X_test.txt", col.names = features$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")

features <- read.table("~/Desktop/Training/Data Science-Coursera/3 Getting and Cleaning Data/Week 4 Editing Text Variables/8 Course Project/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("~/Desktop/Training/Data Science-Coursera/3 Getting and Cleaning Data/Week 4 Editing Text Variables/8 Course Project/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Reading feature

features<-read.table("~/Desktop/Training/Data Science-Coursera/3 Getting and Cleaning Data/Week 4 Editing Text Variables/8 Course Project/UCI HAR Dataset/features.txt")

activity_labels<-read.table("~/Desktop/Training/Data Science-Coursera/3 Getting and Cleaning Data/Week 4 Editing Text Variables/8 Course Project/UCI HAR Dataset/activity_labels.txt")

# Assigning column name for traning and testing tables

colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity_labels) <- c('activityId','activityType')

# Merge data together

train <- cbind(y_train, subject_train, x_train)
test <- cbind(y_test, subject_test, x_test)
AllInOne <- rbind(train, test)


# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 


MeanAndStd <- AllInOne %>% select(activityId, subjectId, contains("mean"), contains("std"))


# 3.Uses descriptive activity names to name the activities in the data set

ActivityNames <- merge(MeanAndStd, activity_labels,
                              by='activityId',
                              all.x=TRUE)

# 4.Appropriately labels the data set with descriptive variable names. 

# Done by the previous step


# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Create tidy data set

TidySet <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
TidySet <- TidySet[order(TidySet$subjectId, TidySet$activityId),]

FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)


#5.2 Writing tidy data set in txt file

write.table(secTidySet, "secTidySet.txt", row.name=FALSE)

