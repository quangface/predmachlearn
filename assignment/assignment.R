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

set.seed(703)
PMLtraining <- createDataPartition(PMLtrain.final$classe, p = 0.8, list = FALSE)
PMLtrain.set <- PMLtrain.final[PMLtraining, ]
PMLtrain.validation <- PMLtrain.final[-PMLtraining, ]
# build the prediction model
PML.model <- randomForest(classe ~ ., data = PMLtrain.set)

PML.model

PMLvalidate <- predict(PML.model, PMLtrain.validation)
confusionMatrix(PMLvalidate,PMLtrain.validation$classe)

PMLpredict <- predict(PML.model, PMLtest.final)
PMLpredict

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(PMLpredict)

