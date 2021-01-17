# Code for question 3

## @knitr 3.init
library(ggplot2)

new <- read.csv(here::here("data/NewSubstations.csv"), 
                  stringsAsFactors=FALSE) %>%
    rename(substation=Substation, date=Date)

new.long <- new %>%
    gather("time", "demand", -c(substation, date)) %>%
    mutate(hour=as.numeric(str_replace(time, "X", "")))

## @knitr 3.i.plot.allday



## @knitr 3.ii.kmeans

new.avg <- new %>%
    select(-date) %>%
    group_by(substation) %>%
    summarise_all(median) %>%
    # summarise_all(mean) %>%
    column_to_rownames(var="substation")

daily.avg %>%
    merge(new.avg) %>%
    head()

km.2 <- new.avg %>% 
    kmeans(2)

km.2$centers


wssplot <- function(data, nc=4, seed=467){
    wss <- (nrow(data)-1)*sum(apply(data, 2, var))
    for (i in 2:nc){
        set.seed(seed)
        wss[i] <- sum(kmeans(data, centers=i)$withinss)
    }
    plot(1:nc, log(wss), type="b", xlab="Number of clusters",
         ylab="Within groups sum of squares")
}
    
wssplot(new.avg)

wssplot(daily.avg, 25, seed=1)
