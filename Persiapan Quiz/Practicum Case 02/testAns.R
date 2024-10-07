Part <- read.csv("Participant.csv")
Ques <- read.csv("Question.csv")
Rslt <- read.csv("Result.csv")

#Check file for missing vals
sum(is.na(Part))

sum(is.na(Rslt))

sum(is.na(Rslt$ParticipantID))

#loop through all cols in rslt to check for is.na
for (i in 1:ncol(Rslt)){
  print(paste((colnames(Rslt)[i])," ",(sum(is.na(Rslt[,i])))))
}

Rslt <- na.omit(Rslt)

# Combine rslt w/ part
Data_comb <- merge(Rslt, Part, by = "Participant.Number")


# 1. Visualize a pie chart with its legend
# get Question.2

Data_no1 <- table(Data_comb$Question.2)
Data_no1
# Data_no1_prc <- prop.table(Data_no1)*100 < dont use
Data_no1_prc <- (100 * Data_no1 / sum(Data_no1))
Data_no1_prc <- round(Data_no1_prc, 2)

# names(Data_no1) <- NULL
no1_legends <- c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")

pie(Data_no1_prc,
    labels = paste("(", Data_no1_prc, "%)", sep=""),
    main = "Result Percentage of Question 2:\nThe lecturers of Bluejack University are masters\nof the corresponding courses taught to me.",
    col = rainbow(length(Data_no1_prc))
)
legend("topright",legend = no1_legends, fill = rainbow(length(Data_no1_prc)), cex = 0.6)

# add parameter inset to move legend bar e.g inset = c(0.1,0.1) < (x,y)

# 2. Visualize a pie chart with its legend, illustrating the result of the sixth question for female participants. 

Data_onlyF <- subset(Data_comb, Data_comb$Gender == "Female")
Data_onlyF_n6 <- table(Data_onlyF$Question.6)
Data_onlyF_n6

Data_onlyF_n6_prc <- (100 * Data_onlyF_n6 / sum(Data_onlyF_n6))
Data_onlyF_n6_prc <- round(Data_onlyF_n6_prc, 2)

no6_legends <- names(Data_onlyF_n6)

pie(Data_onlyF_n6_prc,
    labels = paste("(", Data_onlyF_n6_prc, "%)", sep=""),
    main = "Result Percentage of Question 6 for Female Participants:
    The sanitation facility of Bluejack University
    is well maintained and hygienic.",
    col = rainbow(length(Data_onlyF_n6_prc)))
legend("topright",legend = no6_legends, fill = rainbow(length(Data_onlyF_n6_prc)))

#3 Visualize a group bar chart with its legend, illustrating the result of the 
# first question and the gender of the participant.

Data_onlyM <- subset(Data_comb, Data_comb$Gender == "Male")
Data_onlyF_n1 <- table(Data_onlyF$Question.1)
Data_onlyM_n1 <- table(Data_onlyM$Question.1)

# barplot(Data_onlyF_n1, col = "red", main = "Result")

Combined_data <- rbind(Data_onlyF_n1, Data_onlyM_n1)

no3_legends <- c("Strongly\nDisagree", "Disagree", "Neutral", "Agree", "Strongly\nAgree")

barplot(Combined_data,
        beside = FALSE,
        col = c("red", "orange"),
        main = "Result Percentage of Question 1 :\nThe education materials provided by Bluejack\nis up to date and promises a great\npotential for future.",
        cex.main = 0.8,
        names.arg = no3_legends)
legend("topleft",legend = c("Female","Male"), fill = c("red", "orange"), cex = 0.8)

# 4. Visualize a boxplot, illustrating the relationship between the 
# result of the first question and the gender of the participant.


boxplot(Question.1 ~ Gender,  #< means you select Q1 separated by gender
        data = Data_comb,                   
        main = "Relationship of Gender and Result of Question 1:\nThe education materials provided by Bluejack\nUniversity is up to date and promises a great\npotential for my future.", 
        cex.main = 0.8,
        xlab = "Gender",                    # X-axis label
        ylab = "Question 1 Answer",                    # Y-axis label
        col = c("red", "orange"),
        cex.lab = 0.8, 
        cex.axis = 0.8)   

#5. Visualize a histogram, illustrating the result of the fourth question

Data_no4_frq <- (Data_comb$Question.4)

hist(as.numeric(Data_no4_frq), 
     main = "Result Percentage of Question 4:\nThe staffs of Bluejack University are polite,\nrespectful, and welcoming.",
     xlab = "Question 4 Answer",
     ylab = "Frequency",
     col = c('red',"orange","yellow","green"),
     breaks=5,
     ylim= c(0,50))

#6. Visualize a stacked bar chart, illustrating the results of question 1 to 5.


question_columns <- Data_comb[, c("Question.1", "Question.2", "Question.3", "Question.4", "Question.5")]

counts <- sapply(question_columns, function(x) table(factor(x, levels = 1:5)))

barplot(counts, beside = FALSE, 
        col = rainbow(5), 
        # main = "Distribution of Values for Each Question",
        xlab = "Questions", ylab = "Frequency",
        names.arg = paste("Question", 1:5),
        ylim = c(0, 100),
        space= 0.2,xlim = c(0, 5.5),width = 0.7, 
#                              ^ the larger the thinner the plot area will be
        cex.names = 0.6)
#         ^ use to make x axis text smaller, use cex.axis for y axis
# to make x axis text vertical add ,las = 2
legend("topright",legend = paste("Answered: ",as.character(1:5)), fill = rainbow(5), cex = 0.8)


#7. Visualize a dot chart and a line chart, illustrating the amount of survey participants each day.
data_date <- table(Data_comb$Date)
data_date <- c(data_date[1], "7/16/2018" = 0, data_date[-1])
names(data_date) <- as.character(names(data_date))

plot(data_date, 
     type = "p",
     xlab = "Survey data",
     ylab = "Number of Participants",
     main = "Number of Participant from\n2018-07-14 to 2018-07-20",
     frame.plot = TRUE,xaxt = "n")
axis(1, at = 1:7, labels = paste("2018-07-",as.character(14:20)),cex.axis = 0.6)


plot(data_date, 
     type = "l",
     xlab = "Survey data",
     ylab = "Number of Participants",
     main = "Number of Participant from\n2018-07-14 to 2018-07-20",
     frame.plot = TRUE,xaxt = "n") # xaxt to remove x axis
axis(1, at = 1:7, labels = paste("2018-07-",as.character(14:20)),cex.axis = 0.6)

plot(data_date, 
     type = "o",
     xlab = "Survey data",
     ylab = "Number of Participants",
     main = "Number of Participant from\n2018-07-14 to 2018-07-20",
     frame.plot = TRUE,xaxt = "n") # xaxt to remove x axis
axis(1, at = 1:7, labels = paste("2018-07-",as.character(14:20)),cex.axis = 0.6)

# save through gui

data_date
