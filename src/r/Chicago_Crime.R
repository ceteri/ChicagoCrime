#Analysis Code
data = read.csv("../data/Crimes_-_2008.csv")
a = data$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_time = strftime(df, format="%H:%M:%S")
df_time = strftime(df, format="%H:%M")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk),main="Overall Crime 2008")
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_theft = data[data['Primary.Type']=="THEFT",]
a = data_theft$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk),main="Theft 2008")
df_time = strftime(df, format="%H:%M:%S")
df_time = strftime(df, format="%H:%M")
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_homocide = data[data['Primary.Type']=="HOMICIDE",]
a = data_homocide$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk),main="Homicide 2008")
df_time = strftime(df, format="%m")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_sca = data[data['Primary.Type']=="CRIM SEXUAL ASSAULT",]
a = data_sca$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk),main = "Crim Sexual Assault 2008")
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_nar = data[data['Primary.Type']=="NARCOTICS",]
a = data_nar$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")

df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%d")
plot(as.factor(df_time))

data_pros = data[data['Primary.Type']=="PROSTITUTION",]
a = data_pros$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk),main="Prostitution 2008")
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_bat = data[data['Primary.Type']=="BATTERY",]
a = data_bat$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))


data_mvt = data[data['Primary.Type']=="MOTOR VEHICLE THEFT",]
a = data_mvt$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))


plot(data$Longitude,data$Latitude,  main="Scatterplot Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_homocide$Longitude,data_homocide$Latitude,  main="Homocide Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_theft$Longitude,data_theft$Latitude,  main="Theft Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_sca$Longitude,data_sca$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_mvt$Longitude,data_mvt$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_nar$Longitude,data_nar$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)
plot(table(data$Ward))
plot(table(data_homocide$Ward))
plot(table(data_theft$Ward))
plot(table(data_nar$Ward))
plot(table(data_mvt$Ward))
plot(table(data_sca$Ward))



data = read.csv("~/Personal/Crimes_-_2001_to_present.csv")
a = data$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_time = strftime(df, format="%H:%M:%S")
df_time = strftime(df, format="%H:%M")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))

data_theft = data[data['Primary.Type']=="THEFT",]
a = data_theft$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H:%M:%S")
df_time = strftime(df, format="%H:%M")
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_homocide = data[data['Primary.Type']=="HOMICIDE",]
a = data_homocide$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_sca = data[data['Primary.Type']=="CRIM SEXUAL ASSAULT",]
a = data_sca$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))

data_nar = data[data['Primary.Type']=="NARCOTICS",]
a = data_nar$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")

df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%d")
plot(as.factor(df_time))

data_nar = data[data['Primary.Type']=="PROSTITUTION",]
a = data_nar$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))

data_bat = data[data['Primary.Type']=="BATTERY",]
a = data_bat$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))


data_mvt = data[data['Primary.Type']=="MOTOR VEHICLE THEFT",]
a = data_mvt$Date
dates = as.character(a)
df = strptime(dates, "%m/%d/%Y %I:%M:%S %p")
df_wk <- weekdays(as.Date(df,"%m/%d/%Y %I:%M:%S %p"))
plot(as.factor(df_wk))
df_time = strftime(df, format="%H")
plot(as.factor(df_time))
df_time = strftime(df, format="%m")
plot(as.factor(df_time))


plot(data$Longitude,data$Latitude,  main="Scatterplot Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_homocide$Longitude,data_homocide$Latitude,  main="Homocide Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_theft$Longitude,data_theft$Latitude,  main="Theft Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_sca$Longitude,data_sca$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_mvt$Longitude,data_mvt$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)

plot(data_nar$Longitude,data_nar$Latitude,  main="SCA Longitude Vs Latitude", 
     xlab="Longitude", ylab="Latitude", pch=19)
plot(table(data$Ward))
plot(table(data_homocide$Ward))
plot(table(data_theft$Ward))
plot(table(data_nar$Ward))
plot(table(data_mvt$Ward))
plot(table(data_sca$Ward))


library("randomForest")
?randomForest
data_learn = read.csv("~/Personal/ChicagoCrime-personal/ChicagoCrime/mvt.csv")
d <- data_learn[!is.na(data_learn$Ward),]
data_assault = subset(d,Primary.Type=="HOMICIDE")

data_assault$Primary.Type<- NULL
RF = randomForest(Total ~ . , data = data_assault, ntree = 100 , corr.bias=TRUE, na.action=na.omit)
scorevalid <- as.data.frame(predict(RF, newdata=d))

hclust(data_learn)

# Model Fitting Code 
library("randomForest")
data_learn = read.csv("data/prostitution.csv")
smpl <- data_learn[sample(nrow(data_learn), 1000000),]

data_learn$newCount = ifelse(data_learn$Total >0,1.0,0.0)
data_learn$PER_CAPITA_INCOME = as.numeric(gsub("$","",data_learn$PER_CAPITA_INCOME,fixed=TRUE))

t = smpl[smpl$Total!=0.0,]
dim(t)
t1 = t[1:10000,]
t2 = smpl[smpl$Total==0.0,]
t3 = t2[sample(nrow(t2), 100000),]
tall = rbind(t1,t3)
tall$newCount = ifelse(tall$Total >0,1.0,0.0)
tall$PER_CAPITA_INCOME = as.numeric(gsub("$","",tall$PER_CAPITA_INCOME,fixed=TRUE))

t_test = t[10001:19739,]
t2_test = smpl[smpl$Total==0.0,]
t3_test = t2_test[sample(nrow(t2_test), 100000),]
tall_test = rbind(t_test,t3_test)
tall_test$newCount = ifelse(tall_test$Total >0,1.0,0.0)
tall_test$PER_CAPITA_INCOME = as.numeric(gsub("$","",tall_test$PER_CAPITA_INCOME,fixed=TRUE))

l = glm(newCount ~community_area +hour
       +week+PERCENT_OF_HOUSING_CROWDED+
         PERCENT_HOUSEHOLDS_BELOW_POVERTY+
         HARDSHIP_INDEX+PERCENT_AGED_16_UNEMPLOYED+
         AFRICAN_LANGUAGES+CHINESE+ARABIC+FRENCH+
         HEBREW+KOREAN+SCANDINAVIAN+SPANISH+THAI+GUJARATI+
         PERCENT_AGED_25_WITHOUT_HIGH_SCHOOL_DIPLOMA+
         HINDI+ITALIAN+URDU+POLISH+HUNGARIAN+GERMAN+OTHER_PACIFIC_ISLAND+
         OTHER_WEST_GERMANIC+JAPANESE+GREEK+OTHER_SLAVIC+VIETNAMESE+
         TAGALOG+OTHER_INDO_EURPOEAN+PER_CAPITA_INCOME+
         PERCENT_AGED_UNDER_18_OR_OVER_64, data=tall,family=binomial(link = "logit"))

plot(l)
summary(l)
stepGLM <- step(l, trace=50)
pred_test <- predict(stepGLM, newdata = tall_test , type = "response")

library(ROCR)
#pred_test = predict(l,tall_test)

pred_l = prediction(as.data.frame(pred_test), tall_test$newCount)
perf2_l <- performance(pred_l, "tpr", "fpr")
plot(perf2_l, avg= "threshold", colorize=T, lwd= 3, main= "With ROCR you can produce standard plots like ROC curves ...")


library(verification)
t = ifelse(pred_test>0.33,1,0)
Ver = table.stats(obs=tall_test$newCount, pred=t) 
print(Ver)
summary(l)

l2 = randomForest(newCount ~community_area +hour+month+
                    week+PERCENT_OF_HOUSING_CROWDED+
                    PERCENT_HOUSEHOLDS_BELOW_POVERTY+
                    HARDSHIP_INDEX+PERCENT_AGED_16_UNEMPLOYED+
                    AFRICAN_LANGUAGES+CHINESE+ARABIC+FRENCH+
                    HEBREW+KOREAN+SCANDINAVIAN+SPANISH+THAI+GUJARATI+
                    PERCENT_AGED_25_WITHOUT_HIGH_SCHOOL_DIPLOMA+
                    HINDI+ITALIAN+URDU+POLISH+HUNGARIAN+GERMAN+OTHER_PACIFIC_ISLAND+
                    OTHER_WEST_GERMANIC+JAPANESE+GREEK+OTHER_SLAVIC+VIETNAMESE+
                    TAGALOG+OTHER_INDO_EURPOEAN+PER_CAPITA_INCOME+Year+
                    PERCENT_AGED_UNDER_18_OR_OVER_64, 
                  data=tall,ntree=200,importance=TRUE,
                  do.trace=50,mtry=10)
l2
plot(l2)
varImpPlot(l2, main="Prostitution and Important Variable")
library(ROCR)

pred_test = predict(l2,tall_test)

pred = prediction(as.data.frame(pred_test), tall_test$newCount)
perf2 <- performance(pred, "tpr", "fpr")
plot(perf2, avg= "threshold", colorize=T, lwd= 3, main= "Chicago Crime(Prostitution)")
perf <- performance(pred,"lift","rpp")
plot(perf, main="lift curve", colorize=T)



pred_test = predict(l2,data_learn)

pred = prediction(as.data.frame(pred_test), data_learn$newCount)
perf2 <- performance(pred, "tpr", "fpr")
plot(perf2, avg= "threshold", colorize=T, lwd= 3, main= "Chicago Crime(Prostitution)")
perf <- performance(pred,"lift","rpp")
plot(perf, main="lift curve", colorize=T)



t = ifelse(pred_test>0.43,1,0)
Ver = table.stats(obs=tall_test$newCount, pred=t) 
print(Ver)

pred = prediction(l2$predicted, tall$newCount)
perf2 <- performance(pred, "tpr", "fpr")
plot(perf2, avg= "threshold", colorize=T, lwd= 3, main= "TRP vs FPR")
perf <- performance(pred,"lift","rpp")
plot(perf, main="lift curve", colorize=T)

