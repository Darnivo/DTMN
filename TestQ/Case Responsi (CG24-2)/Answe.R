retail <- read.csv("retail.csv")


##! ex. of cleaning data;
##! retail <- na.omit(retail)

# maybe use , fileEncoding = "UTF-8-BOM"  if 1st col has weird name

# 1.How does the total cost of purchases vary across 
# different customer categories?

boxplot(Total_Cost ~ Customer_Category, 
        #   ^ col a to col b, because of data = retail no need to add retail$
        data=retail,
        main = "Title blablabla",
        xlab = "Category",
        ylab = "Total cost",
        col = rainbow(length(unique(retail$Customer_Category)))
        )

#2. What is the distribution of payment methods used by customers?

  ## so first, count the freq
payment_frq <- table(retail$Payment_Method)

  ## second, turn into percentage
payment_frq_pct <- (100 * payment_frq / sum(payment_frq))
# ^ in right pane data goes only to 1 dp, but is stored to 5 dp, but soal
# minta 2 dp, so round it

payment_frq_pct <- round(payment_frq_pct, digits = 2)
                                        # ^ doesn't need to be written down    
#or alternatively: payment_frq_pct <- round(100 * payment_frq / sum(payment_frq),2)

  ## next, make labels (strings for chart)
payment_lbl = paste(names(payment_frq), "(", payment_frq_pct, "%)", sep="")
# basically just sprintf

  ## last, make chart with pie()
pie(payment_frq_pct,
    labels= payment_lbl, 
    main = "title lalalala",
    col = rainbow(length(payment_frq)))

#3. What are the top 3 popular store types where purchases are made?


  ## make table to count freq
store_frq = table(retail$Store_Type)
  ## sort the freq (descending), then take the top 3
# we wont use order() here, bcs its just a table 
# we'll just use sort()
store_frq_srt = sort(store_frq, decreasing = TRUE)
# param decreasing = FALSE is default, so we change 

store_frq_top3 = head(store_frq_srt,3)
#                                 ^ amount you want
# if you want bottom use tail() instead

##! reverse order by using rev()

  ## make bar plot with barplot()
barplot(store_frq_top3,
        main ="title hahaha",
        xlab ="str type",
        ylab ="freq",
        col = rainbow(length(store_frq_top3))
        #,legend.text = names(store_frq_top3)
        )

##! add text to bar
# bp_ex <- barplot(store_frq_top3,main ="title hahaha",xlab ="str type",ylab ="freq",col = rainbow(length(store_frq_top3)))
# text(bp_ex, 0, round(store_frq_top3, 2),cex=1,pos=3) 
# rm(bp_ex)

store_frq_top3



mkt_dt <- read.csv("market_data.csv")
#A. Data Preprocessing
#1. Process the data that only hails from the department of “beverages”
  ##just take data from bvrg, using subset
mkt_bvg <- subset(mkt_dt, mkt_dt$department=="beverages")

#2. Remove all product which aisle is “soft drinks”
mkt_bvg_sfd <- subset(mkt_dt, mkt_dt$department=="beverages" & mkt_dt$aisle != "soft drinks")
##! alternatively instead of 2 conditions just do subset do mkt_bvg 

#3. Remove all duplicated data for the analysis
mkt_bvg_sfd_ndp <- mkt_bvg_sfd [!duplicated(mkt_bvg_sfd),]
#                                                   dont forget comma

#B Data Transformations
# change the data (Prepare the product data in terms of the product’s name)
# for apriori analysis
# install.packages("arules")

library(arules)
# ^ this is case sensitive

mkt_dt2 <- mkt_bvg_sfd_ndp
##! biar nulis cepet


##! mkt_dt2[2, ] to check vals of 2nd row, mkt_dt2[2] to check all data's 2nd row val
##! if you want to reorder row num >   rownames(mkt_dt2) <- NULL
mkt_dt2[2,]


trc_list <- split(mkt_dt2$product_name,mkt_dt2$order_id)
#first param is what you want to group, 2nd is what its going to be grouped by
# similar to sql's groupby, used to separate


# apriori can only ingest data/obj which class is transactions < actual name
  ## so we need to convert trc_list by typecasting
trc_list_fin <- as(trc_list, "transactions")
#                             ^ copy this verbatim

#C Data Mining
#1. Show frequent product using Apriori algorithm with minimum support:
#   0.02 based on the data that have already pre-processed
freq_iset <- apriori(trc_list_fin, parameter = 
                       list(supp=0.02,target= "frequent itemsets"))
#                           ^ based on soal     ^ copy verbatim

#reading freq_iset uses inspect()
inspect(freq_iset)
##!support > frequency of appearance, count > actual count

#2. Show the association rules using minimum confidence: 0.05 based on
#   the frequent product that resulted from step above.

freq_iset_wrules <- apriori(trc_list_fin, parameter = 
                  list(supp=0.02,target= "rules", conf = 0.05))

inspect(freq_iset_wrules)

# install.packages("dplyr")
# library(dplyr)
