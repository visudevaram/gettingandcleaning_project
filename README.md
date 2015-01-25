# gettingandcleaning_project
Project assignment for Getting and cleaning assignment

The script performs the required activities in following manner:

1. Initially the script reads X_test, X_train files and creates one dataset (final_data) using 'rbind()' 
2. Reads names from features text file and assigns the column names using 'names()' function
3. To get a list of columns containing mean / std, it uses 'SQLDF' package and uses a query with LIKE clause
4. With the retrieved list of required columns, the final dataset is prepared using 'dplyr' package SELECT command
5. The "y_%%%" and "subject_%%%" datasets are added to main dataset using 'cbind()'   
6.  "activity_labels" are merged with final dataset 
7.  The average values are calculated using "summarize_each" function of dplyr package
8.  Final dataset is writted using write.table command 
