orders = read.csv("practicum/quiz/orders.csv")
prod = read.csv("practicum/quiz/products.csv")

library(ggplot2)

ggplot(prod,aes(x = department, y=product_price, fill = department)) + 
  geom_boxplot() +
  scale_fill_manual(values = rainbow(length(unique(prod$department)))) +
  labs ( title= "Plot",  x ="Dep", y = "Price") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle=90,hjust=1), legend.position = "none")

library(dplyr)


dep_cnt <- prod %>%
  group_by(department) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

top_dep <- dep_cnt[1:5,]
oth_dep <- data.frame(department = "Others", count = sum(dep_cnt$count[6:nrow(dep_cnt)]))

final_dt <- rbind(top_dep,oth_dep) %>%
  mutate (proportion = count / sum(count), percentage = paste0(round(proportion * 100,2),"%"))

ggplot(final_dt, aes(x="", y=proportion, fill = department)) +
  geom_bar(stat = "identity", width=1, color="black") + 
  coord_polar("y", start = 0) +
  scale_fill_manual(values = rainbow(nrow(final_dt))) +
  labs (title = "Pie") +
  geom_text(aes(label = percentage), position =position_stack(vjust=0.5))+
  theme_void()


lst_frz<- prod %>%
  filter(department == "frozen") %>%
  group_by(aisle) %>%
  summarise(count =n()) %>%
  arrange(count) %>%
  head(3)

ggplot(lst_frz,aes(x= reorder(aisle,count),y=count)) +
  geom_bar(stat= "identity") + 
  scale_fill_manual(values = rainbow(3)) +
  labs(title = "bar", x = "aisle", y = "count")+
  theme_minimal()
