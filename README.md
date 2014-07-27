gettingandcleaningdata-course-project
=====================================

Course Project for Getting &amp; Cleaning Data

H Seth Berlin

This is the Repo for the submission of the course project for the Johns Hopkins Getting and Cleaning Data course.

Overview

Project is based on data at the UCI Machine Learning Repository.  Source data is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Running This Script

The run_analysis.r file assumes that the UCI HAR files are stored in this directory:  "/UCI HAR Dataset/".  Once you have obtained and unzipped the source files, you will need to change line 11 to set your working directory correctly. You may also want to set line 91 so that it writes the tidy data file to your preferred location as it will currently write it to the working directory.

Project Summary

The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Additional Information

You can find additional information about the variables, data and transformations in the CodeBook.MD file.
