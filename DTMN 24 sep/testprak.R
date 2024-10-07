testd = read.csv("Exchange Rate.csv", fileEncoding = "UTF-8-BOM")
typeof(testd$Date)


#divide data
rateBTC  <- testd[testd$Cryptocurrency == "BTC",]
# ^ rememeber comma at end
rateETH <-testd[testd$Cryptocurrency == "ETH",]
rateXRP <-testd[testd$Cryptocurrency == "XRP",]

#sorting
rateBTCsorted <- rateBTC[order(rateBTC$Date,rateBTC$Time),]
rateETHsorted <- rateETH[order(rateETH$Date,rateETH$Time),]
rateXRPsorted <- rateXRP[order(rateXRP$Date,rateXRP$Time),]

rateETH16Ag <- rateETH[rateETH$Date=="16-Aug-18",]

#first
rateETH16Ag$Price[1]

#last
rateETH16Ag$Price[nrow(rateETH16Ag)]

rateBTC15Ag <- rateBTC[rateBTC$Date=="15-Aug-18",]
rateBTC15Agsorted <- rateBTC15Ag[order(rateBTC15Ag$Price),]

#low 
rateBTC15Agsorted$Price[1]
#high
rateBTC15Agsorted$Price[nrow(rateBTC15Agsorted)]
