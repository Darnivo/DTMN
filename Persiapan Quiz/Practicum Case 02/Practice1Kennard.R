library("dplyr")
library("arules")
library("ggplot2")

participantdf <- read.csv("Participant.csv", fileEncoding = "UTF-8-BOM")
resultdf <- read.csv("Result.csv", fileEncoding = "UTF-8-BOM")
questiondf <- read.csv("Question.csv", fileEncoding = "UTF-8-BOM")

resultdf <- na.omit(resultdf)
participantdf <- na.omit(participantdf)
questiondf <- na.omit(questiondf)

# No. 1 
question2 <- resultdf %>%
  group_by(Question.2) %>%
  summarise(count = n()) 
 
question2 <- question2 %>%
  mutate(percentage = round(count/sum(count)*100,1))

pieLabs <- paste(question2$percentage)
legendTitle <- c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")
pie(question2$count,labels = pieLabs, col = rainbow(length(question2$count)), main = "Result
    Percentage of Question 2 : The lecturers of Bluejack University are masters of the corresponding courses
    taught to me.")
legend("topright", legend = legendTitle, fill = rainbow(length(question2$count)), cex = 0.6)

# No. 2 
question6 <- merge(resultdf, participantdf, by = "Participant.Number")
question6 <- question6 %>%
  filter(Gender == "Female")

question6 <- question6 %>%
  group_by(Question.6) %>%
  summarise(count = n())

question6 <- question6 %>%
  mutate(percentage = round(count/sum(count)*100, 1))

pieLabs <- paste(question6$percentage)
pie(question6$count, labels = pieLabs, col = rainbow(length(question6$count)),
    main = "Result Percentage of Question 6 for Female Participants : The sanitation
    facility of Bluejack Universityt is well maintained and hygenic.")

legendTitle = c("FALSE", "TRUE")
legend("topright", legend = legendTitle, fill = rainbow(length(question6$count)), cex = 0.6)

# No. 3 
mergedf <- merge(resultdf, participantdf, by = "Participant.Number") 

question1 <- mergedf %>%
  group_by(Gender, Question.1) %>%
  summarise(count = n()) %>%
  ungroup()

q1.frequency <- t(table(mergedf$Question.1, mergedf$Gender == 'Male'))

names <- c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")
barplot(q1.frequency, col = rainbow(length(mergedf)), 
        names.arg = c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"),
        main = "Result Percentage of Question 1: The education materials provided by Bluejack
        University is up to date and promises a great potential for my future")
legend ("topleft", legend = c("Female", "Male"), fill = c("red", "orange"))

# No. 4
boxplot(mergedf$Question.1 ~ mergedf$Gender, 
        data = mergedf, col = c("red", "orange"),
        main = "Realtionship of Gender and Reuslt of Question 1:
        The education materials provided by Bluejack University is up
        to date and promises a great potential for my future.",
        xlab = " Question 1 Answer", 
        ylab = "Gender")

# No. 5 GATAU
question4 <- mergedf %>%
  group_by(Question.4) %>%
  summarise(count = n())

var <- rep(question4$Question.4, question4$count)


hist(
  var,
  breaks = seq(0.5, 5.5, by = 1), # Breaks to center bars at integers
  col = rainbow(length(question4$Question.4)),                   # Color of the bars
  main = "Histogram of Question 4 Responses",  # Title
  xlab = "Response",              # Label for the x-axis
  ylab = "Frequency",             # Label for the y-axis
  xlim = c(0, 5)    
)
