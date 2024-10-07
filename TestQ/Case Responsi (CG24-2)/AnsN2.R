retail <- read.csv("retail.csv")

for (i in 1:ncol(retail)){
  print(paste((colnames(retail)[i])," ",(sum(is.na(retail[,i])))))
}

nrow(retail)

# How does the total cost of purchases vary across different customer
# categories?
boxplot(Total_Cost ~ Customer_Category,
        data = retail,
        main = "Total Cost by Customer Category",
        xlab = "Categcry",
        ylab = "Total cost",
        col = rainbow(length(unique(retail$Customer_Category))))

#What is the distribution of payment methods used by customers?
pay_mtd <- table(retail$Payment_Method)
pay_mtd_prc <- round((100 * pay_mtd / sum(pay_mtd)),2)
pay_lbl = paste(names(pay_mtd),"(",pay_mtd_prc,"%)",sep="")

pie(pay_mtd,
    labels = pay_lbl,
    col = rainbow(length(pay_mtd)),
    main = "Distribution of Payment Methods")

#What are the top 3 popular store types where purchases are made?

str_frq <- table(retail$Store_Type)

str_frq_sorted <- sort(str_frq, decreasing = TRUE)
str_frq_srt_t3 <- head(str_frq_sorted,3)


barplot(str_frq_srt_t3,
    main="Top 3 Store Types by Frequency",
    args.legend = names(str_frq_srt_t3),
    xlab = "Store type",
    ylab = "Frequency",
    col = rainbow(3),
    )
# legend("topright",legend = names(str_frq_srt_t3),fill = rainbow(3))

# Data Preprocessing
mkt_dt <- read.csv("market_data.csv")

#Take only bvg
bvg_dt <- subset(mkt_dt,mkt_dt$department == "beverages")


#Remove sd
bvg_noSD_dt <- subset(bvg_dt,!bvg_dt$aisle == "soft drinks")


#Remove dupe
bvg_noSD_noDP_dt <-  bvg_noSD_dt[!duplicated(bvg_noSD_dt),]


#Data Transformations
library(arules)

data_v2 <-  bvg_noSD_noDP_dt

data_v2[2,]

trans_list <- split(data_v2$product_name,data_v2$order_id)
trans_list_fin <- as(trans_list, "transactions")

#DTMN
freq_iset <- apriori(trans_list_fin,parameter = 
                       list(supp=0.02, target = "frequent itemsets"))

inspect(freq_iset)

freq_iset_conf <- apriori(trans_list_fin,parameter = 
                       list(supp=0.02, conf = 0.05, target = "rules"))

inspect(freq_iset_conf)
