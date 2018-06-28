# Getting and Cleaning Data Course Project

library(tidyverse)

tidyTrainingData <- function() {
    zippedDirectoryName <- "UCI HAR Dataset.zip"
    directoryUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    unzippedDirectoryName <- "UCI HAR Dataset"
    
    # Download the data set and unzip it
    if (!file.exists(zippedDirectoryName)) {
        download.file(directoryUrl, destfile = zippedDirectoryName, method = "curl")
        dateDownloaded <- date()
    }
    
    if (!file.exists(unzippedDirectoryName)) {
        unzip(zippedDirectoryName)
    }
    
    # Read the data, converting relevant data to tbl_df for later tyding in dplyr and tidyr
    activityLabels <- tbl_df(read.table(file.path(unzippedDirectoryName, "activity_labels.txt"), 
                                        col.names = c("activityId", "activityName")))

    
    features <- read.table(file.path(unzippedDirectoryName, "features.txt"))
    
    
    # Read the test data; Assigning variable names based on README.txt
    testDataBasePath <- file.path(unzippedDirectoryName, "test")
    testSubjects <- tbl_df(read.table(file.path(testDataBasePath, "subject_test.txt"), col.names = "subjectId"))
    testFeatureSet <- tbl_df(read.table(file.path(testDataBasePath, "X_test.txt"), col.names = features[, 2]))
    testActivityLabels <- tbl_df(read.table(file.path(testDataBasePath, "y_test.txt"), col.names = "activityId"))
    
    # Read the training data; Assigning variable names based on README.txt
    trainingDataBasePath <- file.path(unzippedDirectoryName, "train")
    trainSubjects <- tbl_df(read.table(file.path(trainingDataBasePath, "subject_train.txt"), col.names = "subjectId"))
    trainFeatureSet <- tbl_df(read.table(file.path(trainingDataBasePath, "X_train.txt"), col.names = features[, 2]))
    trainActivityLabels <- tbl_df(read.table(file.path(trainingDataBasePath, "y_train.txt"), col.names = "activityId"))
    
    
    #
    # 1. Merge the data into one set
    #
    subject_data <- bind_rows(testSubjects, trainSubjects) 
    featureSet_data <- bind_rows(testFeatureSet, trainFeatureSet) 
    activityLabels_data <- bind_rows(testActivityLabels, trainActivityLabels) 
    combined_data <- bind_cols(subject_data, activityLabels_data,featureSet_data) 
    #combined_data
    
    #
    # 2. Extract only mean and std 
    #
    relevantColumns <- grepl("subject|activity|mean|std", colnames(combined_data))
    combined_data <- combined_data[, relevantColumns]
    
    #
    # 3. Use proper activity names
    #
    combined_data$activityId <- factor(combined_data$activityId, 
                                       levels = activityLabels$activityId, 
                                       labels = activityLabels$activityName)
    
    
    #
    # 4. Use appropriate variable names
    #
    combinedDataColumnNames <- colnames(combined_data)
    combinedDataColumnNames <- gsub("[\\(\\)-]", "", combinedDataColumnNames) 
    combinedDataColumnNames <- gsub("Freq", "Frequency", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("^f", "Frequency", combinedDataColumnNames) 
    combinedDataColumnNames <- gsub("^t", "Time", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("Acc", "Accelerometer", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("Gyro", "Gyroscope", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("Mag", "Magnitude", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("mean", "Mean", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("std", "StandardDeviation", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("BodyBody", "Body", combinedDataColumnNames)
    combinedDataColumnNames <- gsub("^activityId", "activity", combinedDataColumnNames)
    
    colnames(combined_data) <- combinedDataColumnNames
    
    #
    # 5. Create separate tidy set
    #
    combined_data %>%
        unique() %>%
        group_by(subjectId, activity) %>%
        summarise_all(.funs = mean) %>%
        arrange(subjectId, desc(activity)) %>%
        write.table("./tidySet.txt", row.names = FALSE)
    
}
