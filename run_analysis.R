
install.packages ("reshape2")


library(reshape2)

#1  Set Working Directory
#NOTE:  This assumes that UCI HAR Dataset is under the folowing directory path
#  C:/...../Course Project/UCI HAR Dataset/

setwd ('/PTT/Education/cleaning data/Course Project/UCI HAR Dataset/')

#  Import the files needed for the tidy data set
# start by importing files that relate to both the train and test datasets

activity_Labels = read.table('./activity_labels.txt',header=FALSE);
features = read.table('./features.txt',header=FALSE);

#  Import train data

x_Train = read.table('./train/x_train.txt',header=FALSE);
y_Train = read.table('./train/y_train.txt',header=FALSE);
subject_Train = read.table('./train/subject_train.txt',header=FALSE);

# Import test data
subject_Test = read.table('./test/subject_test.txt',header=FALSE);
y_Test = read.table('./test/y_test.txt',header=FALSE);
x_Test = read.table('./test/x_test.txt',header=FALSE);

# Get Dimensions of all imported files

dim(activity_Labels);
dim (features);
dim (subject_Test);
dim (subject_Train);
dim (x_Test);
dim (x_Train);
dim (y_Test);
dim (y_Train);

#Go back and figure out how to tie the imported files together

# Bind the Test Data Together 2947 subjects * 563 columns
bind_Test_Data <- cbind(subject_Test, x_Test, y_Test);

# Bind the Train Data Together 7352 subjects * 563 columns
bind_Train_Data <- cbind(subject_Train, x_Train, y_Train);

# Bind the two datasets together 10299 *563
Total_Bind <- rbind (bind_Test_Data, bind_Train_Data);

# Assign Column Names to the Total_Bind array
feature_Columns <- as.character(features[,2]); #creates a character vector based on columns in features.txt
column_Names <- c("SubjectID", feature_Columns, "ActivityID");
colnames(Total_Bind) <- column_Names

#2 Extract only measurements on mean and stdev for each measurement
#
#  Create a vector that includes columns (mean & std) for tidy data set
std_Dev_Columns <- grep("std()",column_Names) # columns inclusive of std
mean_Columns <- grep("mean()",column_Names) #columns inclusive of mean
full_Columns <- c(1,mean_Columns, std_Dev_Columns,563) #Tidy Data Set Columns
#
#Create the Tidy Data Set
tidy_Data_Set <- Total_Bind[full_Columns]
#
# 3  Use descriptive activity names to name the activities in the data set by merging final data set with activity_Labels table
colnames(activity_Labels) <- c("ActivityID", "Label"); # ActivityID is the join
tidy_Data_Set = merge (tidy_Data_Set,activity_Labels,by="ActivityID", all.x=TRUE);
#
# 4  Appropriately labels the data set with descriptive variable names. 
tolower(names(tidy_Data_Set)); #lowers variable names to lower cases
tidyNames <- names(tidy_Data_Set)
tidyNames <- gsub("[[:punct:]]", " ", tidyNames); #removes -,(,),
tidyNames <- gsub("std", "stdev", tidyNames)
tidyNames <- gsub("^(t)", "time", tidyNames)
tidyNames <- gsub("^(f)", "frequency", tidyNames)
tidyNames <- gsub("Label", "Activity", tidyNames)
tidyNames <- gsub("bodybody", "body", tidyNames)
tidyNames <- gsub("\\s","",tidyNames)

# Reassign descriptive column names to the main observation table
names(tidy_Data_Set) <- tidyNames

#5  Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyMeasures <- tidyNames[-c(1,2,82)]; #getting a list of measures to melt data
tidyMelt <- melt(tidy_Data_Set, id=c("SubjectID", "Activity"), measure.vars=c(tidyMeasures)); #melting tidy data set
final_tidy_Activity <- dcast(tidyMelt, Activity + SubjectID ~ variable, mean); # dcasts so get a mean for each Activity by Subject

# Write the dataset
write.table(final_tidy_Activity, file="./tidydata4.txt", sep="\t", row.names=FALSE)
