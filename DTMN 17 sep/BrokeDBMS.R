#data manipulation <like db query 

#ex df
df2 <- data.frame(Name=c("Adolf","Josef","Leopold","Hideki","Molotov","Winston"),
                 Age=c(74,88,35,66,45,72), Score=c(90,40,99,45,61,74))

#select
# ^ uses dplyr lib
library(dplyr)

df2

selection <- select(df2,Name)
selection
#filter

filtering <- filter(df2, Age>50)
filtering

#sort

#default is ascending, use desc()
sorted <- arrange(df2,desc(Score))
sorted
