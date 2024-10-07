# file > new > r script / ctrl shift n
# ctrl shift c to make comment ine

#vector
courses <- c("comvis","combio","comphys","comstat","comint")
freq <- c(11,22,33,44,55)


#pie chart
pieLabel <- round(freq*100/sum(freq),2)
pie(freq,labels=courses,main="courses")

pie(freq,labels=pieLabel,main="courses",col = rainbow(length(courses)))

#legends
legend("topleft",courses, fill = rainbow(length(courses)))

#run all > ctrl + enter (select lines)


#bar plot
barplot(freq,names.arg = courses, xlab = courses,ylab = freq,col = c("grey","white"))

#histogram
hist(freq, main="Title",col = rainbow(length(courses)), border = "yellow")

#boxplot
boxplot(freq,col="green")

#Line graph
plot(freq,xlab="Courses", ylab="Freq",col="blue", type="o")

