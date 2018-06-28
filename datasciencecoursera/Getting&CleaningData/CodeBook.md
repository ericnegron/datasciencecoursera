# Getting and Cleaning Data Course Project Code Book

This code book details the data, variables, and transformations used to create the `tidySet.txt` file.

A link to the original study has been included in the `README.md` file in this respository.

## Data
The `tidySet.txt` file is text file containing the average of each type of activity, organized by activity and subject.

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

  These measurements can be broken into two categories:
  * **Time Domain Signals**:  captured at a constant rate of 50hz and filtered using median and 3rd order low pass Butterworth filters.
  
    * Average time domain for body acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometer.MeanX`
      * `TimeBodyAccelerometer.MeanY`
      * `TimeBodyAccelerometer.MeanZ`
      
    * Standard deviation for time domain body acceleration in X,Y,Z directions:
    
      * `TimeBodyAccelerometer.StandardDeviationX`
      * `TimeBodyAccelerometer.StandardDeviationY`
      * `TimeBodyAccelerometer.StandardDeviationZ`
      
    
    
  * **Frequency Domain Signals**: signals processed with a Fast Fourier Transform to select time domain signals.
    
    
  
  
    
