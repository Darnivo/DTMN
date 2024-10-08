# Practicum Case 02 Code

## 1
```r
n2_lbl <-c("Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree")

pie(data_n2,
    labels = data_n2_prc,
    col = rainbow(length(data_n2)),
    main = "title")
legend("topright",n2_lbl,fill = rainbow(length(data_n2)),cex = 0.6)

```
![n1](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n1.png)

## 2
```r
pie(data_onlyF_n6,
    labels = data_onlyF_n6_prc,
    col = rainbow(length(data_onlyF_n6)),
    main = "title")
# legend("topright",c("FALSE","TRUE"),fill = rainbow(length(data_onlyF_n6)),cex = 0.6)
legend("topright",names(data_onlyF_n6),fill = rainbow(length(data_onlyF_n6)))
```
![n2](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n2.png)

## 3
```r
n1_lbl <-c("Strongly\nDisagree", "Disagree", "Neutral", "Agree", "Strongly\nAgree")

barplot(data_MF_n1,
        col = c("red","orange"),
        main = "title",
        names.arg = n1_lbl
        )
legend("topleft",c("Female","Male"), fill = c("red","orange"), cex = 0.8)
```
![n3](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n3.png)

## 4
```r
boxplot(Question.1 ~ Gender,
        data = data_comb,
        col = c("red","orange"),
        xlab = "g",
        ylab = "freq",
        main = "ttl",
        names = c("cstm txt", "Male"))
```
![n4](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n4.png)

## 5
```r
data_n4 <- data_comb$Question.4

hist(data_n4, 
     breaks=5,
     col = c('red',"orange","yellow","green"),
     ylab = "freq",
     xlab = "q4 ans",
     main = "ttl",
     ylim = c(0,50))
```
![n5](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n5.png)

## 6
```r
barplot(tpose_data_1to5,
        # main = "ttl",
        names.arg = paste("Question.",as.character(1:5),sep=""),
        col = rainbow(nrow(tpose_data_1to5)),
        ylim = c(0,100),
        space= 0.2,xlim = c(0.2, 5.5),width = 0.7,
        cex.names = 0.7)
legend("topright",legend = paste("Answered:",as.character(1:5)),fill = rainbow(nrow(tpose_data_1to5)), cex = 0.8)
```
![n6](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n6.png)

## 7a
```r
plot(data_date_new, 
     type = "p",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)
```
![n7a](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n7a.png)


## 7b
```r
plot(data_date_new, 
     type = "l",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)
```
![n7b](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n7b.png)


## 8
```r
plot(data_date_new, 
     type = "o",
     xlab = "sr date",
     ylab = "n of par",
     main = "ttl", xaxt="n")
axis(1,at = 1:7,labels = paste("2018-07-",as.character(14:20),sep=""), cex.axis = 0.75)

```
![n8](https://github.com/Darnivo/DTMN/blob/main/Persiapan%20Quiz/Practicum%20Case%2002/imgs/n8.png)
