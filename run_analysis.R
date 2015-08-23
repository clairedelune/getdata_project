rawX <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
rawy <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
trawX <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
trawy <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)


## STEP 1 - Merges the training and the test sets to create one data set.

raw <- rbind(trawX, rawX) # raw is our new unique data set
act <- rbind(trawy, rawy) # act will serve later


## STEP 2 - Extracting only the measurements on the mean and standard
## deviation for each measurement using an index.

idmean <- grepl("mean()",features[,2], fixed=TRUE) #mean(): Mean value
idstd <- grepl("std()",features[,2], fixed=TRUE) #std(): Standard deviation

id<-vector()
for(i in 1:561) { # loop merging the 2 newly created indexes
    if(idmean[i]!=0) {id[i]<-T}
    else if(idstd[i]!=0) {id[i]<-T}
    else {id[i]<-F}
}        

meanstd <- raw[,id] # extracts only the requested fields


## STEP 3 - Uses descriptive activity names to name the activities in the data set

# undone, I was too short in time for achieving it


## STEP 4 - Appropriately labels the data set with descriptive variable names.

labels <- features[id,2]
colnames(meanstd) <- labels


## STEP 5 - From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

# Calculating the average for each measurement (because I couldn't finish the rest)
cmeans<-colMeans(meanstd)

write.table(cmeans, "cmeans.txt", row.names = FALSE) # for submitting the results

# cleaning-up the environment before the script exits, removing all variables except
# the most tidy one (cmeans in this case).
rm(features, rawX, rawy, trawX, trawy, idmean, idstd, id, labels, raw, act, meanstd)