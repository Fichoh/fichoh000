library(dplyr)

#Train sets
xtrain<-read.table('train\\X_train.txt')
ytrain<-read.table('train\\y_train.txt')
subject_train<-read.table('train\\subject_train.txt')
#Test sets
xtest<-read.table('test\\X_test.txt')
ytest<-read.table('test\\y_test.txt')
subject_test<-read.table('test\\subject_test.txt')

#merging
xbind<-rbind(xtrain,xtest)
ybind<-rbind(ytrain,ytest)
subject_bind<-rbind(subject_train,subject_test)

#Features
features<-read.table('tidy_data\\UCI HAR Dataset\\features.txt')
activity_label<-read.table('tidy_data\\UCI HAR Dataset\\activity_labels.txt')

#assign names in 2nd features column to header in xbind
names(xbind)<-features[,2]

#Locate columns only calculating mean or std
exmeanstd<-grep('mean\\(\\)|std\\(\\)',names(xbind))

##Extract columns only calculating mean or std
extractxbind<-xbind[,exmeanstd]

#merge ybind and subject_bind to extractbind

complete_data<-cbind(extractxbind,ybind,subject_bind)

names(complete_data)[67:68]<- c('Activity','Subject')

#convert integer activity column to activity label factors
for (i in activity_label[,1]) {
    complete_data$Activity[complete_data$Activity==i]<-as.character(activity_label[i,2])
    
}
complete_data$Activity<-as.factor(complete_data$Activity)

complete_data$Subject<-as.factor(complete_data$Subject)

names(complete_data)<-sub('-mean\\(\\)','Mean',names(complete_data))
names(complete_data)<-sub('-std\\(\\)','Std',names(complete_data))

complete_data



complete_data<- group_by(complete_data,Activity,Subject)%>%summarise_all(funs(mean))


