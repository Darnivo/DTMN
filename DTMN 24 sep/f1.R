#Data description & visualization
#quiz at session 5 (not s6, 40% weight)

vct1 = c(2,3,4,5)
vct2 = c("a","bb","ccc", NA, NA,"dddd",NA,"E")

print(vct2)

is.na(vct2)

vct3 = na.omit(vct2)

na.omit(vct2)

vct2[is.na(vct2)] <- 
  c("a","bbb","ff")

vct2

duplicated(vct2)

#Score vector
scores <- c(100,50,70,100,75,65,100,35)

#Review dataframe

df1 <- data.frame(Names=vct2, scores = scores)


# "," selects all cols
df1[!duplicated(df1),]
# ^ checks for same val in both cols

df1 <- df1[!duplicated(df1),]



#read.csv vs read.csv2
#iris.csv from data viz zip
#default sep for csv is comma, csv2 is semicolon
csv1 <- read.csv("iris.csv")
csv2 <- read.csv2("iris.csv",sep=',',dec='.')


#aggregate > statistics 
meanS = mean(scores)
medianS = median(scores)
stdevS = sd(scores)

#subset
datas <- subset(csv1, csv1$Species == "Iris-setosa", select = SepalLengthCm:Species)
                                                    # ^ select cols
datas2 <- subset(csv1, csv1$Species == "Iris-setosa", select = c("SepalLengthCm","PetalLengthCm","Species"))
rm(datas)



#data preprocessing

testMN <- mean(datas$SepalLengthCm)
testMD <- median(datas$SepalWidthCm)
testSD <- sd(datas$SepalLengthCm)
# ^ only works with vectors (so only 1 col at a time)
