X_test <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

Y_test <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")

X <- rbind(X_train, X_test)##Merging the test and train data
Y <- rbind(Y_train, Y_test)

features <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity <- read.table("~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

mean_list <- grep("mean", features$V2)
std_list <- grep("std", features$V2)
library(dplyr)
new <- c(mean_list,std_list)
new <- sort(new)

X_new <- select(X,new)

desired_length <- 10299 # or whatever length you want
a <- vector(mode = "list", length = desired_length)

## Step 3
for(i in 1:10299){
  a[i] = Y[i,1]
}
a <- as.integer(a)
for(i in 1:10299){
  Y$V1[i]=activity$V2[a[i]]
}

colnames(Y) <- c("activity")


## Step 4
colnames(X_new) <- features$V2[new]


data <- cbind(Y,X_new)
colnames(data) <- gsub("-"," ",names(data))
colnames(data) <- gsub("\\()","",names(data))
colnames(data) <- gsub(" ","",names(data))

## Step 5
tidy_data <- group_by(data, activity)
new_dataset <- summarize_all(tidy_data,list(mean))
