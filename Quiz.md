# Quiz ans

### File (Movies.csv)
| Attribute    | Data      | Type Description                                   |
|--------------|-----------|----------------------------------------------------|
| movieID      | Integer   | Unique ID in the Movies                            |
| Title        | Character | The title of the movie                             |
| Year         | Integer   | The release year of the movie                      |
| IMDb Rating  | Numeric   | The IMDb rating of the movie                       |
| Runtime Mins | Integer   | The runtime of the movie in minutes                |
| Num Votes    | Integer   | The number of votes the movie received on IMDb     |
| Directors    | Character | The directors of the movie                         |

### Ex:
| movieID | Title            | Title.Type | IMDb.Rating | Runtime..mins. | Year | Genres                     | Num.Votes | Directors   |
|---------|------------------|------------|-------------|----------------|------|----------------------------|-----------|-------------|
| 1       | Spider-Man       | movie      | 7.3         | 121            | 2002 | Action, Adventure, Sci-Fi  | 670777    | Sam Raimi   |
| 2       | Spider-Man 2     | movie      | 7.3         | 127            | 2004 | Action, Adventure, Sci-Fi  | 528482    | Sam Raimi   |
| 3       | Spider-Man 3     | movie      | 6.2         | 139            | 2007 | Action, Adventure, Sci-Fi  | 485814    | Sam Raimi   |
| 4       | The Matrix       | movie      | 8.7         | 136            | 1999 | Action, Sci-Fi             | 1615984   | Lilly Wachowski, Lana Wachowski   |

## 1. Data Visualization

### 1a. Show Distribution of IMDb Ratings based on IMDb Ratings.
```r
rtng_dist <- mov$IMDb.Rating

hist(rtng_dist,
     breaks = 17,
     col= "red",
     main = "Distribution of IMDb Ratings",
     xlab = "IMDb Rating",
     ylab = "Number of Movies", 
     cex.lab = 0.8, cex.axis = 0.8)
```
![n1](https://raw.githubusercontent.com/Darnivo/DTMN/refs/heads/main/Q%20Res/n1.png)

### 1b. Show the top 5 genres with the highest average IMDb rating that has more than 1000 votes

#### Method 1 (With dplyr / tidyr)
```r
names(mov_over1k)

by_genre <- mov_over1k %>%
  separate_rows(Genres, sep = ",") %>%
  group_by(Genres) %>%
  summarise(avg_rating = mean(IMDb.Rating)) %>%
  arrange(desc(avg_rating))
  
top5_genre <- head(by_genre, 5)

barplot(top5_genre$avg_rating, 
        names.arg = top5_genre$Genres, 
        main = "Top 5 Genres with Highest Average IMDb Rating", 
        xlab = "Genres", 
        ylab = "Average IMDb Rating",
        col = rainbow(5))
```

#### Method 2 (For loop hell)
```r
v2_by_genre <- list()
for (i in 1:nrow(mov_over1k)){ 
  genres <- unlist(strsplit(as.character(mov_over1k$Genres[i]), ","))
  for (genre in genres){
    if(is.null(v2_by_genre[[genre]])){
      v2_by_genre[[genre]] <- c(mov_over1k$IMDb.Rating[i])
    } else {
      v2_by_genre[[genre]] <- c(v2_by_genre[[genre]], mov_over1k$IMDb.Rating[i])
    }
  }
}

v2_ratings <- sapply(v2_by_genre, mean)
v2_rating_srt <- sort(v2_ratings, decreasing = TRUE)
v2_top5_genre <- head(v2_rating_srt, 5)
  
barplot(v2_top5_genre, 
        names.arg = names(v2_top5_genre), 
        main = "Top 5 Genres with Highest Average IMDb Rating", 
        xlab = "Genres", 
        ylab = "Average IMDb Rating",
        col = rainbow(5))
```

#### Results
| Rank | Genres     | avg_rating |
|------|------------|------------|
| 1    | Western    | 8.550000   |
| 2    | History    | 7.642105   |
| 3    | Biography  | 7.100000   |
| 4    | Action     | 6.982353   |
| 5    | Crime      | 6.842500   |
| 6    | War        | 6.803448   |
| 7    | Short      | 6.766667   |
| 8    | Biography  | 6.733333   |
| 9    | Animation  | 6.680435   |
| 10   | Drama      | 6.632143   |


![n2](https://raw.githubusercontent.com/Darnivo/DTMN/refs/heads/main/Q%20Res/n2.png)

### 1c. Show the number of movies by duration with 3 categories as below:
`(< 90 mins,90-120 mins,> 120 mins)`
```r
mov_u90 <- subset(mov, mov$Runtime..mins. < 90)
mov_o120 <- subset(mov, mov$Runtime..mins. > 120)
mov_90to120 <- subset(mov, mov$Runtime..mins. >= 90 & mov$Runtime..mins. <= 120)

dur_dist <- c(nrow(mov_u90), nrow(mov_90to120), nrow(mov_o120))
dur_dist_prc <- round(dur_dist/sum(dur_dist)*100, 2)

pie_lbl <- c("< 90 mins", "90-120 mins", "> 120 mins")
pie(dur_dist, 
    labels = pie_lbl, 
    main = "Number of Movies Based on Duration", 
    col = c("lightblue","lightgreen","salmon"))
```
![n3](https://raw.githubusercontent.com/Darnivo/DTMN/refs/heads/main/Q%20Res/n3.png)

## 2. FP analysis
### File (Movies.csv & Transaction.csv)
### Ex:
| transactionID | movieID |
|---------------|---------|
| 1             | 1       |
| 2             | 2       |
| 3             | 3       |
| 3             | 4       |
| 3             | 5       |
| 4             | 4       |
| 4             | 5       |

```r
  library(arules)
```
### Merge the Movies.csv and Transaction.csv file based on the movieID
```r
trans <- read.csv("./Dataset/Transaction.csv")

merged_dt <- merge(trans, mov, by = "movieID")
```
### A. Data preprocessing

#### 1. Remove the movie year under ‘1995’.
```r
merged_dt_over95 <- subset(merged_dt, merged_dt$Year > 1995)
```
#### 2. Remove movies with less than 150,000 votes.
```r
merged_dt_over95_over150 <- subset(merged_dt_over95, merged_dt_over95$Num.Votes > 150000)
```
#### 3. Remove movies directed by Michael Bay.
```r
 merged_dt_over95_over150_noBay <- subset(merged_dt_over95_over150, merged_dt_over95_over150$Director != "Michael Bay")
```

### B. Data Transformation
Prepare the data in terms of the genres
```r
dt_finished_proc <- merged_dt_over95_over150_noBay
dt_finished_proc_spl <- split(dt_finished_proc$Genres, dt_finished_proc$transactionID)
dt_finished_proc_spl_trc <- as(dt_finished_proc_spl, "transactions")
```

### C. Data Mining
#### Show frequent genres using apriori algorithm with minimum support of 0.01 based on the data that have already pre-processed.

```r
freq_iset <- apriori(dt_finished_proc_spl_trc, 
                     parameter = list(support = 0.01, target = "frequent itemsets"))
inspect(freq_iset)
```
![prio](https://raw.githubusercontent.com/Darnivo/DTMN/refs/heads/main/Q%20Res/prio.png)


###Show the association rules using minimum confidence of 0.1 based on the frequent genres that resulted from step above.
```r
inspect(ruleInduction(freq_iset, conf = 0.1))
```
![rind](https://raw.githubusercontent.com/Darnivo/DTMN/refs/heads/main/Q%20Res/rind.png)

