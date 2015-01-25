library(dplyr)
test_data = read.table("test/X_test.txt")
train_data = read.table("train/X_train.txt")
final_data = rbind(train_data,test_data)
names_data = read.table("features.txt")
names_data$V2 = make.names(names_data$V2,unique=T)

names(final_data) = names_data$V2

library(sqldf) 
sel_col = sqldf("select V2 from names_data where V2 LIKE '%mean%' OR V2 LIKE '%std%'")

i <- match(sel_col$V2, names(final_data))

data = final_data %>% select(i)

y_test = read.table("test/y_test.txt")
names(y_test) = "activity_no"
y_train = read.table("train/y_train.txt")
names(y_train) = "activity_no"
subject_test = read.table("test/subject_test.txt")
names(subject_test) = "subject"
subject_train = read.table("train/subject_train.txt")
names(subject_train) = "subject"

activity = rbind(y_train,y_test)
subject = rbind(subject_train, subject_test)
data = cbind(activity,subject,data)

activity_labels = read.table("activity_labels.txt")
names(activity_labels) = c("activity_no","activity_description")

tidy_data = merge(activity_labels,data,by.x="activity_no",by.y="activity_no",all=TRUE)

tidy_avg_data = tidy_data %>% group_by(activity_no,activity_description,subject) %>% summarise_each(funs(mean))

write.table(tidy_avg_data,"tidy_data.txt",row.name=FALSE)
