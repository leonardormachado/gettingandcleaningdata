# ASSIGNMENT SUBMITTED BY LEONARDO MACHADO FOR COURSERA
# GETTING AND CLEANING DATA COURSE PROJECT

# Assignment instructions
# You should create one R script called run_analysis.R that does the following

# 1) Merges the training and the test sets to create one data set
# 2) Extracts only the measurements on the mean and standard deviation for each measurement
# 3) Uses descriptive activity names to name the activities in the data set 
# 4) Appropriately labels the data set with descriptive variable names
# 5) From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject

# Preparing the workspace
# This script considers that the zipped file has been downloaded and was unzipped to the folder below
path <- paste0(getwd(),"/Coursera/Data Cleaning/UCI HAR Dataset/")

# Loads FEATURES column names into variable for manipulation
featuresNames <- read.table(paste0(path,"features.txt"), stringsAsFactors = FALSE)

# Filters only MEAN and STANDARD DEVIATION for each measurement
featuresFiltered <- grep(".*-mean.*|.*-std.*", featuresNames[,2])
featuresNames <- featuresNames[featuresFiltered,2]

# Using DESCRIPTIVE VARIABLE NAMES
# Replacing the "-mean" and "std" and "[()-]"
featuresNames = gsub('-mean', 'Mean', featuresNames)
featuresNames = gsub('-std', 'StdDev', featuresNames)
featuresNames = gsub('[()-]', '', featuresNames)

# Replacing other words in the variables
featuresNames = gsub('^t', 'time', featuresNames)
featuresNames = gsub('^f', 'frequency', featuresNames)
featuresNames = gsub('Acc', 'Acceleration', featuresNames)
featuresNames = gsub('Gyro', 'Gyroscope', featuresNames)
featuresNames = gsub('Mag', 'Magnitude', featuresNames)

# Loads ACTIVITY LABELS into variable for manipulation
activitiesLabels <- read.table(paste0(path,"activity_labels.txt"), stringsAsFactors = FALSE)
activitiesLabels <- activitiesLabels[,2]

# Loads the TRAIN datasets
trainData <- read.table(paste0(path,"/train/X_train.txt"))
trainData <- trainData[, featuresFiltered]
trainActivities <- read.table(paste0(path,"/train/Y_train.txt"))
trainSubjects <- read.table(paste0(path,"/train/subject_train.txt"))
trainData <- cbind(trainSubjects, trainActivities, trainData)

# Loads the TEST datasets
testData <- read.table(paste0(path,"/test/X_test.txt"))
testData <- testData[, featuresFiltered]
testActivities <- read.table(paste0(path,"/test/Y_test.txt"))
testSubjects <- read.table(paste0(path,"/test/subject_test.txt"))
testData <- cbind(testSubjects, testActivities, testData)

# Combining TRAIN and TEST data frames
completeDataset <- rbind(trainData, testData)
colnames(completeDataset) <- c("SubjectID", "ActivityDescription", featuresNames)

# Creating file with the desired COMPLETE dataset
write.table(completeDataset, "completeDataset.txt", row.names = FALSE)

# Loading library reshape2
library(reshape2)


# Converting ACTIVITY and SUBJECTS into factors
activitiesLabels <- read.table(paste0(path,"activity_labels.txt"), stringsAsFactors = FALSE)
completeDataset$ActivityDescription <- factor(completeDataset$ActivityDescription, levels = activitiesLabels[,1], labels = activitiesLabels[,2])
completeDataset$SubjectID <- as.factor(completeDataset$SubjectID)

# Summarize data using reshape2
completeReshaped <- melt(completeDataset, id = c("SubjectID", "ActivityDescription"))
summarizedDataset <- dcast(completeReshaped, SubjectID + ActivityDescription ~ variable, mean)

# Creating file with the desired SUMMARIZED dataset
write.table(summarizedDataset, "summarizedDataset.txt", row.names = FALSE)
