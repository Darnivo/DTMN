install.packages("arules")
# package for association rules
library(arules)

data <- read.csv("./basic/data.csv", header = TRUE, sep = ",")

data  <- data[,-1]

freq_isets <- apriori(data, parameter = list (support = 0.22, target = "frequent itemsets"))
#                                                 ^ like soal        ^ dont change str

freq_isets

# v from arules
inspect(freq_isets)


#rule induction
inspect(ruleInduction(freq_isets, confidence = 0.6))


# apriori implementation
header <- read.csv("./apriori/header.csv")
detail <- read.csv("./apriori/detail.csv")
items  <- read.csv("./apriori/items.csv")

mergedData <- merge(header, detail, by.x = "header_id", by.y ="transaction_id")
#                                           ^ data column name

mergedData <- merge(mergedData, items, by.x = "item_id", by.y ="id")


mergedData$item_id <- mergedData$name

mergedData <- na.omit(mergedData)

splitData <- split(mergedData$item_id, mergedData$header_id)

library(arules)

itemsets <- apriori(splitData, parameter = list (support = 0.05, target = "frequent itemsets"))

inspect(itemsets)
inspect(ruleInduction(itemsets, confidence = 0.5))


# FP growth
system('cmd', input = 'fpgrowth')

system('cmd', input = 'fpgrowth -s22 -k, ./basic/data2.csv output.csv')










