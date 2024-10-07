install.packages("ggplot2")

library(ggplot2)

#dataframes

df = data.frame(x = rnorm(100),y = rnorm(100))

#rnorm > random vals

#scatter plot
ggplot(df,aes(x=x,y=y))+
  geom_point() +
  theme_dark()
