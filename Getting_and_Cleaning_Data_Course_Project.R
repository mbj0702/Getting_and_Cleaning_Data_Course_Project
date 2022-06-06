# reads and stores subject data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# reads and stores x data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# reads and stores y data
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# combines and stores train data and test data
subject_data <- rbind(subject_train, subject_test)
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

# reads and stores activity labels and features
activity_labels <- read.table(paste("UCI HAR Dataset/activity_labels.txt"))
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table(paste("UCI HAR Dataset/features.txt"))

# gets required column, mean, and standard deviation
feat_column <- grep("-(mean|std).*", as.character(features[,2]))
column_name <- features[feat_column, 2]
column_name <- gsub("-mean", "Mean", column_name)
column_name <- gsub("-std", "Std", column_name)
column_name <- gsub("[-()]", "", column_name)

# gets column data and store them by their names
x_data <- x_data[feat_column]
combined_data <- cbind(subject_data, y_data, x_data)
colnames(combined_data) <- c("subject", "activity", column_name)
combined_data$subject <- as.factor(combined_data$subject)
combined_data$activity <- factor(combined_data$activity, levels = a_label[,1], labels = a_label[,2])


#5. creates tidy data
temp_data <- melt(combined_data, id = c("subject", "activity"))
tidy_data <- dcast(temp_data, subject + activity ~ variable, mean)
write.table(tidy_data, "./tidy_data.txt", row.names = FALSE, quote = FALSE)