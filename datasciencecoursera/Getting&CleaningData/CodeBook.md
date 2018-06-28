# Getting and Cleaning Data Course Project Code Book

This code book details the data, variables, and transformations used to create the `tidySet.txt` file.

A link to the original study has been included in the `README.md` file in this respository.

## Data
The `tidySet.txt` file is text file containing the average of each type of activity, organized by activity and subject.

Original source data files used for tidying obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):
* `activity_labels.txt` : contains activity names and ids
* `features.txt` : contains the observation method names
* `X_test.txt` : contains the test set observations
* `y_test.txt` : containts the test set observation labels
* `subject_test.txt` : contains the test set subject ids
* `X_train.txt` : contains the training set observations
* `y_train.txt` : contatins the training set observation labels
* `subject_train.txt` : contains the training set subject ids

Original source data files used for information on source data set:
* `README.txt`
* `features_info.txt`

## Transformations
Source data was obtained by downloding using the `curl` method of `download.file()`.

Once downloaded the following transformations were made to arrive at the final tidy data set:
1. Separate data sets were merged together to form one combined data set.
   * Training subjects and test subjects were merged using `bind_rows()`
   * Training and test feature sets were merged using `bind_rows()`
   * Training and test activity labels were merged using `bind_rows()`
   * All merged sets were then combined using `bind_cols()`
2. The columns of the combined data set were searched for "subject", "activity", "mean", or "std" using `grepl()`.  This extracted only the variables that contained the standard deviation or mean of that method while still retaining the `subject` and `activityId` columns.
3.  The descriptive activity names were added to the `activity` column by creating a factor of the activity observations and mapping them to the corresponding `activityId`.
4.  The feature names were cleaned up using `gsub()`.
    * `(`, `)`, `-` characters were removed 
    * Method abbreviations were removed and replaced with full word (ex: `Acc` was replaced with `Accelerometer`)
    * `mean` and `std` were capitalized to keep with the camel case patern of the variable names
    * Initial `f` and `t` were expanded to `Frequency` and `Time` to represent frequency and time domains
    * Duplicate `BodyBody` was replaced with singular `Body`
    * `activityId` column name was changed to `activity` to represent prior replacement of activity id numbers with their corresponding names.
5. The combined data was piped through a series of `dplyr` functions:
   * `unique()` grabbed only unique values
   * `group_by()` grouped the data by `subjectId` and `activity` name
   * All data was then summarized to grab the `mean` of all values using `summarise_all()`
   * Resulting data was then arranged by `subjectId` and `activity` alphabetically by using `arrange()`
6. `tidySet.txt` written out to file 

## Variables
* `subjectId`
  
  An integer value numbered 1 - 30 identifying the study subject
 
* `activity`
  
  The name of the activity the subject performed.  There are 6 possible values:
  * `LYING`
  * `STANDING`
  * `SITTING`
  * `WALKING_DOWNSTAIRS`
  * `WALKING_UPSTAIRS`
  * `WALKING`
  
* Average of measurements obtained by the device

  From the original data set's `features_info.txt`:
  >The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

  These measurements can be broken into two categories with values ranging from -1 to 1:
  * **Time Domain Signals**:  captured at a constant rate of 50hz and filtered using median and 3rd order low pass Butterworth filters.
  
    * Average time domain for body acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometer.MeanX`
      * `TimeBodyAccelerometer.MeanY`
      * `TimeBodyAccelerometer.MeanZ`
      
    * Standard deviation for time domain body acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometer.StandardDeviationX`
      * `TimeBodyAccelerometer.StandardDeviationY`
      * `TimeBodyAccelerometer.StandardDeviationZ`
      
    * Average time doman for gravity acceleration in X,Y,Z directions:
    
      * `TimeGravityAccelerometer.MeanX`
      * `TimeGravityAccelerometer.MeanY`
      * `TimeGravityAccelerometer.MeanZ`
      
    * Standard deviation for time doman gravity acceleration in X,Y,Z directions:
    
      * `TimeGravityAccelerometer.StandardDeviationX`
      * `TimeGravityAccelerometer.StandardDeviationY`
      * `TimeGravityAccelerometer.StandardDeviationZ`
    
    * Average time doman for body jerk acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometerJerk.MeanX`
      * `TimeBodyAccelerometerJerk.MeanY`
      * `TimeBodyAccelerometerJerk.MeanZ`
      
    * Standard deviation for time domain body jerk acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometerJerk.StandardDeviationX`
      * `TimeBodyAccelerometerJerk.StandardDeviationY`
      * `TimeBodyAccelerometerJerk.StandardDeviationZ`
    
    * Average time doman for body angular velocity in X,Y,Z directions:
    
      * `TimeBodyGyroscope.MeanX`
      * `TimeBodyGyroscope.MeanY`
      * `TimeBodyGyroscope.MeanZ`
      
    * Standard deviation for body angular velocity in X,Y,Z directions:
    
      * `TimeBodyGyroscope.StandardDeviationX`
      * `TimeBodyGyroscope.StandardDeviationY`
      * `TimeBodyGyroscope.StandardDeviationZ`
      
    * Average time domain for body jerk angular velocity in X,Y,Z directions:
    
      * `TimeBodyGyroscopeJerk.MeanX`
      * `TimeBodyGyroscopeJerk.MeanY`
      * `TimeBodyGyroscopeJerk.MeanZ`
      
    * Standard deviation for time domain body jerk angular velocity in X,Y,Z directions
      
      * `TimeBodyGyroscopeJerk.StandardDeviationX`
      * `TimeBodyGyroscopeJerk.StandardDeviationY`
      * `TimeBodyGyroscopeJerk.StandardDeviationZ`
      
    * Average time domain for magnitude of body acceleration: 
    
      * `TimeBodyAccelerometerMagnitude.Mean`
      
    * Standard deviation for time domain of magnitude of body acceleration:
    
      * `TimeBodyAccelerometerMagnitude.StandardDeviation`
      
    * Average time domain for magnitude of gravity acceleration: 
    
      * `TimeGravityAccelerometerMagnitude.Mean`
      
    * Standard deviation for time domain magnitude of gravity acceleration:
    
      * `TimeGravityAccelerometerMagnitude.StandardDeviation`
    
    * Average time domain for magnitude of body jerk acceleration:
      
      * `TimeBodyAccelerometerJerkMagnitude.Mean`
      
    * Standard deviation for time domain of magnitude of body jerk acceleration:
    
      * `TimeBodyAcclerometeJerkMagnitude.StandardDevation`
      
    * Average time for magnitude of angular velocity of body:
    
      * `TimeBodyGyroscopeMagnitude.Mean`
      
    * Standard deviation for magnitude of angular velocity of body:
    
      * `TimeBodyGyroscopeMagnitude.StandardDeviation`
      
    * Average time for magnitude of angular velocity of body jerk:
    
      * `TimeBodyGyroscopeJerkMagnitude.Mean`
      
    * Standard deviation for magnitude of angular velocity of body jerk:
    
      * `TimeBodyGyroscopeJerkMagnitude.StandardDeviation`
    
    
  * **Frequency Domain Signals**: signals processed with a Fast Fourier Transform to select time domain signals.
    
    * Average frequency domain body acceleration in X,Y,Z directions:
      
      * `FrequencyBodyAccelerometer.MeanX`
      * `FrequencyBodyAccelerometer.MeanY`
      * `FrequencyBodyAccelerometer.MeanZ`
      
    * Standard deviation for frequency domain body acceleration in X,Y,Z directions:
    
      * `FrequencyBodyAccelerometer.StandardDeviationX`
      * `FrequencyBodyAccelerometer.StandardDeviationY`
      * `FrequencyBodyAccelerometer.StandardDeviationZ`
      
    * Weighted average frequency domain for body acceleration in X,Y,Z directions:
    
      * `FrequencyBodyAccelerometer.MeanFrequencyX`
      * `FrequencyBodyAccelerometer.MeanFrequencyY`
      * `FrequencyBodyAccelerometer.MeanFrequencyZ`
  
    * Average frequency domain body jerk  acceleration in X,Y,Z directions:
      
      * `FrequencyBodyAccelerometerJerk.MeanX`
      * `FrequencyBodyAccelerometerJerk.MeanY`
      * `FrequencyBodyAccelerometerJerk.MeanZ`
      
    * Standard deviation for frequency domain bodyjerk acceleration in X,Y,Z directions:
    
      * `FrequencyBodyAccelerometerJerk.StandardDeviationX`
      * `FrequencyBodyAccelerometerJerk.StandardDeviationY`
      * `FrequencyBodyAccelerometerJerk.StandardDeviationZ`
      
    * Weighted average frequency domain for body jerk acceleration in X,Y,Z directions:
    
      * `FrequencyBodyAccelerometerJerk.MeanFrequencyX`
      * `FrequencyBodyAccelerometerJerk.MeanFrequencyY`
      * `FrequencyBodyAccelerometerJerk.MeanFrequencyZ`
      
    * Average frequency domain for body angular acceleration in X,Y,Z directions:
    
      * `FrequencyBodyGyroscope.MeanX`
      * `FrequencyBodyGyroscope.MeanY`
      * `FrequencyBodyGyroscope.MeanZ`
      
    * Standard deviation for frequency domain of body angular acceleration in X,Y,Z directions:
    
      * `FrequencyBodyGyroscope.StandardDeviationX`
      * `FrequencyBodyGyroscope.StandardDeviationY`
      * `FrequencyBodyGyroscope.StandardDeviationZ`
      
    * Weighted average frequency domain for body angular acceleration in X,Y,Z directions:
    
      * `FrequencyBodyGyroscope.MeanFrequencyX`
      * `FrequencyBodyGyroscope.MeanFrequencyY`
      * `FrequencyBodyGyroscope.MeanFrequencyZ`
      
    * Average of the frequency compenents for magnitude of body accleration: 
    
      * `FrequencyBodyAccelerometerMagnitude.Mean`
      
    * Standard deviation of the frequency components for magnitude of body acceleration:
    
      * `FrequencyBodyAccelerometerMagnitude.StandardDeviation`
      
    * Weighted average of the frequency components for magnitude of body acceleration:
    
      * `FrequencyBodyAccelerometerMagnitude.MeanFrequency`
      
    * Average of the frequency compenents for magnitude of body jerk accleration: 
    
      * `FrequencyBodyAccelerometerJerkMagnitude.Mean`
      
    * Standard deviation of the frequency components for magnitude of body jerk acceleration:
    
      * `FrequencyBodyAccelerometerJerkMagnitude.StandardDeviation`
      
    * Weighted average of the frequency components for magnitude of body jerk acceleration:
    
      * `FrequencyBodyAccelerometerJerkMagnitude.MeanFrequency`

    * Average of the frequency compenents for magnitude of body angular velocity: 
    
      * `FrequencyBodyGyroscopeMagnitude.Mean`
      
    * Standard deviation of the frequency components for magnitude of body angular velocity:
    
      * `FrequencyBodyGyroscopeMagnitude.StandardDeviation`
      
    * Weighted average of the frequency components for magnitude of body angular velocity:
    
      * `FrequencyBodyGyroscopeMagnitude.MeanFrequency`
      
    * Average of the frequency compenents for magnitude of body jerk angular velocity: 
    
      * `FrequencyBodyGyroscopeJerkMagnitude.Mean`
      
    * Standard deviation of the frequency components for magnitude of body jerk angular velocity:
    
      * `FrequencyBodyGyroscopeJerkMagnitude.StandardDeviation`
      
    * Weighted average of the frequency components for magnitude of body jerk angular velocity:
    
      * `FrequencyBodyGyroscopeJerkMagnitude.MeanFrequency`
      
