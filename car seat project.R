#import packages

install.packages("ISLR")
install.packages("tree")

#select & activate packages

library(ISLR)
library(tree)

#import data to environment
data()
data(package="ISLR") #returns all data in islr package
data("Carseats")

#explore your data set

View(Carseats)
names(Carseats)
summary(Carseats)
str(Carseats)
#which data set attribute will be the class label to make prediction
#build classification model for sales

plot(Carseats$Sales, Carseats$CompPrice)
plot(Carseats$Sales, Carseats$Advertising)
hist(Carseats$Sales) #normal distribution
head(Carseats$Sales,3)
tail(Carseats$Sales,3)
range(Carseats$Sales)
class(Carseats)

#Preprocessing step
Carseats<-na.omit(Carseats)    #funtion to get rid of null values
high <-ifelse(Carseats$Sales >=8,'yes','no')
high <- as.factor(high)           # convert class variable to labels (chr need to be changed to factor)
Carseats <-data.frame(Carseats, high)

#create subclass 
Carseats <- subset(Carseats, select = Sales)

#create train data set and testing data set
set.seed(233) #make sure to get the exact same random values in training
train.index <- sample(1:nrow(Carseats),.8*nrow(Carseats))
train.set <- Carseats[train.index,]
test.set <- Carseats[-train.index,]
high.test <- high[-train.index]


#train classification model
dtree <- tree(high~.,train.set)   #. means all attributes included
plot(dtree)
text(dtree, pretty =0)
summary(dtree)  #look at error rate for training tree

#testing trained decision tree
dtree.train <- predict(dtree,test.set, type = 'class')
table(high.test, dtree.test)
(39+17)/80
#of predicted 80% correct

#cross validation of train dtree
cv.tree(dtree,FUN = prune.misclass)
pruned.tree <- prune.misclass(dtree, best = 13)
plot(pruned.tree)
text(pruned.tree)

summary(pruned.tree) #look at misclassification error

pruned.tree.test <- predict(pruned.tree,test.set, type= 'class')
table(high.test,pruned.tree.test)
(41+18)/80  #0.737
(39+17)/80 #size 26 =0.7, which means our model did a bit better
