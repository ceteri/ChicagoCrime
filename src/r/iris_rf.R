library(pmml)
library(randomForest)
require(graphics)

## split data into test and train sets
data(iris)
iris_full <- iris
colnames(iris_full) <-
  c("sepal_length", "sepal_width", "petal_length",
    "petal_width", "species")

idx <- sample(150, 100)
iris_train <- iris_full[idx,]
iris_test <- iris_full[-idx,]

## train a Random Forest model
f <- as.formula("as.factor(species) ~ .")
fit <- randomForest(f, data=iris_train, proximity=TRUE, ntree=50)
print(fit$importance)
print(fit)
print(table(iris_test$species, predict(fit, iris_test, type="class")))

## visualize results
plot(fit, log="y", main="Random Forest")
varImpPlot(fit)
MDSplot(fit, iris_full$species)

## export PMML + test data
out <- iris_full
out$predict <- predict(fit, out, type="class")

saveXML(pmml(fit), "iris.rf.xml")
