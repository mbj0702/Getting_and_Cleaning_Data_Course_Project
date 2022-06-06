---
title: "Getting and Cleaning Data Course Project"
output: codebook.md
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

library(reshape2)

# reads and stores subject data
s_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))
subject_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

# reads and stores x data
x_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
x_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))

# reads and stores y data
y_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
y_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))

# combines and stores train data and test data
subject_data <- rbind(subject_test, s_test)
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

# reads and stores activity labels and features
activity_labels <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# gets required column, mean, and standard deviation
feat_column <- grep("-(mean|std).*", as.character(feature[,2]))
column_name <- feature[feat_column, 2]
column_name <- gsub("-mean", "Mean", column_name)
column_name <- gsub("-std", "Std", column_name)
column_name <- gsub("[-()]", "", column_name)

# gets column data and store them by their names
x_data <- x_data[feat_column]
combined_data <- cbind(subject_data, y_data, x_data)
columns(combined_data) <- c("subject", "activity", column_name)
combined_data$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
combined_data$Subject <- as.factor(allData$Subject)

#5. creates tidy data
temp_data <- melt(combined_data, id = c("Subject", "Activity"))
tidy_data <- dcast(temp_data, Subject + Activity ~ variable, mean)
write.table(tidy_data, "./tidy_data.txt", row.names = FALSE, quote = FALSE)
