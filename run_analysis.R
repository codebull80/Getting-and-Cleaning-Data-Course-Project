library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


download.file(fileUrl, "Coursera_DS3_Final.zip", method="curl")

unzip("Coursera_DS3_Final.zip")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","vectors"))
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$vectors)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$vectors)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")



x_train_test <- rbind(x_train, x_test)
y_train_test <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
experiment <- cbind(Subject, x_train_test, y_train_test)


mean_sd_extraction <- experiment %>% select(subject, label, contains("mean"), contains("std"))

mean_sd_extraction$label <- as.character(mean_sd_extraction$label)
for (i in 1:6){
  mean_sd_extraction$label[mean_sd_extraction$label == i] <- as.character(activities_labels[i,2])
}

mean_sd_extraction$label <- as.factor(mean_sd_extraction$label)

names(mean_sd_extraction)[2] = "activity"
names(mean_sd_extraction)<-gsub("Acc", "Accelerometer", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("Gyro", "Gyroscope", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("BodyBody", "Body", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("Mag", "Magnitude", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("^t", "Time", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("^f", "Frequency", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("tBody", "TimeBody", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("-mean()", "Mean", names(mean_sd_extraction), ignore.case = TRUE)
names(mean_sd_extraction)<-gsub("-std()", "STD", names(mean_sd_extraction), ignore.case = TRUE)
names(mean_sd_extraction)<-gsub("-freq()", "Frequency", names(mean_sd_extraction), ignore.case = TRUE)
names(mean_sd_extraction)<-gsub("angle", "Angle", names(mean_sd_extraction))
names(mean_sd_extraction)<-gsub("gravity", "Gravity", names(mean_sd_extraction))

StudyData <- mean_sd_extraction %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(StudyData, "TidyStudyData.txt", row.name=FALSE)