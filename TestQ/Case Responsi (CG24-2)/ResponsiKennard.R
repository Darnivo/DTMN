library("arules")
library("dplyr")
library("ggplot2")

retaildf <- read.csv("retail.csv")

## Number 1 
# a. 
ggplot(retaildf, aes(x = Customer_Category, y = Total_Cost, fill = Customer_Category)) + 
  geom_boxplot() + 
  labs(title = "Total Cost by Customer Category") 

boxplot(retaildf$Total_Cost ~ retaildf$Customer_Category, 
        data = retaildf,
        main = "Total Cost by Customer Category",
        xlab = "Customer Category",
        ylab = "Total Cost",
        col = rainbow(length(unique(retaildf$Customer_Category)))
        )
## Fix

# b. 
countPayment <- retaildf %>%
  group_by(Payment_Method) %>%
  summarise(count = n())

countPayment <- countPayment %>%
  mutate(percentage = round(count/sum(count)*100, 2))

pieLabs <- paste(countPayment$Payment_Method, "(", countPayment$percentage,"%", ")")

pie(countPayment$count, main = "Distribution of Payment Methods", 
    labels = pieLabs, col = rainbow(length(countPayment$Payment_Method)))

# c. 
countStore <- retaildf %>%
  group_by(Store_Type) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

countStore <- countStore %>%
  slice_max(count, n = 3)

barplot(countStore$count, names.arg = countStore$Store_Type,
        main = "Top 3 Store Types by Frequency", 
        col = rainbow(length(countStore$Store_Type)), 
        xlab = "Store Type",
        ylab = "Frequency")

## Number 2. 
# a. 
marketdf <- read.csv("market_data.csv")

marketdf <- marketdf %>%
  filter(department == "beverages")

marketdf <- marketdf %>%
  filter(aisle != "soft drinks")

marketdf <- marketdf[!duplicated(marketdf), ]

# b. 
transaction.list <- split(marketdf$product_name, marketdf$order_id)

transaction.list.final <- as(transaction.list, "transactions") # This has to be "transactions" with an s 

# c. 
frequent.itemsets <- apriori(transaction.list.final, parameter = list(supp = 0.02, 
                                                                      target = "frequent itemsets"))
inspect(frequent.itemsets)

frequent.itemsets <- apriori(transaction.list.final, parameter = list(supp = 0.02, 
                                                                      conf = 0.05, 
                                                                      target = "rules"))
inspect(frequent.itemsets)
