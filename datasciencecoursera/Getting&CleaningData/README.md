# Getting & Cleaning Data Course Project

This project involves obtaining and cleaning human activity data collected from a Samsung Galaxy smart phone.  

## Study Overview
The study involved 30 volunteers aged 19-48 who performed a variety of activities while wearing a Samsung smart phone on their waist.  The smart phone's accelerometer and gyroscope recorded data, that was then split into two sets: 70% into training data, and 30% into test data.  
* The original data set can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  
* The full description of the study can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


## Repository Contents
* `README.md` : explanation of scripts used for tidying
* `run_analysis.R` : script used for tidying original data set
* `readTidyData.R` : helper script for reading and viewing tidy data set
* `tidySet.txt` : output of the run_analysis.R script (tidy data set)
* `CodeBook.md` : explanation of variables, data, and processes used 

## Process Breakdown
The `run_analysis.R` script obtains the `UCI HAR Dataset` then organizes the data into a tidy data set.  The script was broken up into separate chunks to organize logic and make reading the script easier.  The order of operations is as follows:
* Install Packages
* Obtain Data
* Read the Data
* Step 1: Merge the data into one set
* Step 2: Extract only the mean and std
* Step 3: Use the proper activity names
* Step 4: Use appropriate variable names
* Step 5: Create the separate tidy set

Comments have been used throughout the script for organizing each chunk of code and follow the above breakdown.

`dplyr` package has been used throughout the script and was installed via the `tidyverse` package.

All tables have been converted to `tibble`s via `tbl_df()` for its printing abilities and its ease of use with `dplyr`.

`CodeBook.md` will have a more detailed description of transformations utilized in the `run_analysis.R` script.

## Reading The Tidy Data
A helper script has been included for ease of reading the `tidySet.txt` data.  Alternatively, it is possible to run 
```r
tidySet <- read.table(file.path("./tidySet.txt"))
View(tidySest)
``` 
in the console while in the working directory to read and view the tidy data set.  

The `readTidyData.R` script assumes your current working directory is the same as that in which the `tidySet.txt` file resides. 
