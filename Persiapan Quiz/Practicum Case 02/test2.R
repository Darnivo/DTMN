Part <- read.csv("Participant.csv")
Ques <- read.csv("Question.csv")
Rslt <- read.csv("Result.csv")

sum(is.na(Part))
sum(is.na(Rslt))

Rslt <- na.omit(Rslt)

data_comb <- merge (Rslt, Part, by = "Participant.Number")

# colnames(Rslt)


# 1.Visualize a pie chart with its legend, illustrating 
# the result of the second question

data_n2 <- table(data_comb$Question.2)
data_n2_prc <- round((data_n2*100/sum(data_n2)),2)
n2_lbl <-c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")

pie(data_n2,
    labels = data_n2_prc,
    col = rainbow(length(data_n2)),
    main = "title")
legend("topright",n2_lbl,fill = rainbow(length(data_n2)),cex = 0.6)

#Visualize a pie chart with its legend illustrating the 
#result of the sixth question for female participants. 
data_onlyF <- subset(data_comb, Gender == "Female")
data_onlyF_n6 <- table(data_onlyF$Question.6)

data_onlyF_n6_prc <- round((data_onlyF_n6*100/sum(data_onlyF_n6)),2)

pie(data_onlyF_n6,
    labels = data_onlyF_n6_prc,
    col = rainbow(length(data_onlyF_n6)),
    main = "title")
# legend("topright",c("FALSE","TRUE"),fill = rainbow(length(data_onlyF_n6)),cex = 0.6)
legend("topright",names(data_onlyF_n6),fill = rainbow(length(data_onlyF_n6)))



# Visualize a group bar chart with its legend, illustrating the 
# result of the first question and the gender of the participant.
data_onlyM <- subset(data_comb, Gender == "Male")
data_onlyF_n1 <- table(data_onlyF$Question.1)
data_onlyM_n1 <- table(data_onlyM$Question.1)

data_MF_n1 <- rbind(data_onlyF_n1,data_onlyM_n1)

n1_lbl <-c("Strongly\nDisagree", "Disagree", "Neutral", "Agree", "Strongly\nAgree")

barplot(data_MF_n1,
        col = c("red","orange"),
        main = "title",
        names.arg = n1_lbl
        )
legend("topleft",c("Female","Male"), fill = c("red","orange"), cex = 0.8)
# box()

# tpose <- t(data_MF_n1)
# tpose <- as.data.frame(tpose)
# colnames(tpose) <- c("blabla", "hehe")


# Visualize a boxplot, illustrating the relationship between the 
# result of the first question and the gender of the participant.

boxplot(Question.1 ~ Gender,
        data = data_comb,
        col = c("red","orange"),
        xlab = "g",
        ylab = "freq",
        main = "ttl",
        names = c("cstm txt", "Male"))

# alternatively use this + add xaxt = "n" to param
# axis(1,at = 1:2, labels = c("a","b"),cex.axis = 1)

data_n4 <- data_comb$Question.4

hist(data_n4, 
     breaks=5,
     col = c('red',"orange","yellow","green"),
     ylab = "freq",
     xlab = "q4 ans",
     main = "ttl",
     ylim = c(0,50))


data_no1 <- table(data_comb$Question.1)
data_no2 <- table(data_comb$Question.2)
data_no3 <- table(data_comb$Question.3)
data_no4 <- table(data_comb$Question.4)
data_no5 <- table(data_comb$Question.5)

data_1to5 <-rbind(data_no1,data_no2,data_no3,data_no4,data_no5)

tpose_data_1to5 <- t(data_1to5)


question_columns <- data_comb[, 3:7]
counts <- sapply(question_columns, function(x) table(factor(x, levels = 1:5)))

barplot(tpose_data_1to5,
        # main = "ttl",
        names.arg = paste("Question.",as.character(1:5),sep=""),
        col = rainbow(nrow(tpose_data_1to5)),
        ylim = c(0,100),
        space= 0.2,xlim = c(0.2, 5.5),width = 0.7,
        cex.names = 0.7)
legend("topright",legend = paste("Answered:",as.character(1:5)),fill = rainbow(nrow(tpose_data_1to5)), cex = 0.8)


data_date <- table(data_comb$Date)

data_date_new <- c(data_date[1], "7/15/2018" = 0, data_date[-1])
data_date_new

plot(data_date_new, 
     type = "p",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)

plot(data_date_new, 
     type = "l",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)

plot(data_date_new, 
     type = "o",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)

