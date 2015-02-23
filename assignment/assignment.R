library(randomForest)
library(caret)
library(ggplot2)
library(lattice)

download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", 
              destfile = "./PML_TRAIN.csv")
download.file("http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", 
              destfile = "./PML_TEST.csv")

PMLtrain1 <- read.csv("PML_TRAIN.csv", na.strings=c("","NA","#DIV/0"))
PMLtest1 <- read.csv("PML_TEST.csv", na.string=c("","NA", "#DIV/0")) 

colSums(is.na(PMLtrain1))/nrow(PMLtrain1)

clean <- colSums(is.na(PMLtrain1)) == 0
PMLtrain2 <- PMLtrain1[,clean]
PMLtest2 <- PMLtest1[,clean]

head(PMLtrain2)

PMLtrain.final <- PMLtrain2[,-(1:7)]
PMLtest.final <- PMLtest2[,-(1:7)]


