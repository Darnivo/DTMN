#Aggregate
# ^ uses dplyr

df3 <- data.frame(Name=c("Adolf","Josef","Leopold","Hideki","Adolf","Josef"),
                  Age=c(74,88,35,66,45,72), Score=c(90,40,99,45,61,74))

#Counting
dCounter <- df3 %>%
  group_by(Name) %>%
  summarize(Count = n())  #returns a column

dCounter

dAvg <- df3 %>%
  group_by(Name) %>%
  summarize(Average = mean(Score))  #returns a column

dAvg


df4 <- data.frame(Name=c("St","Na","Vi","St","Na","Vi"), Age=c(11,22,33), Score=c(75,85,95))
#   ^ age & score will repeat in largest col % num of data == 0

df4
