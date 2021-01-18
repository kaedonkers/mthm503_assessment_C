# Code for question 1

## @knitr 1Init

library(ggplot2)
library(GGally)

## @knitr 1iGgpairs

chars %>%
    select(c(type, rating, percentage.ic)) %>%
    ggpairs(mapping = ggplot2::aes(colour=type),
            legend=1,
            columns=2:3,
            upper=c(continuous=wrap("cor")),
            diag=list(continuous=wrap("barDiag")),
            lower=list(continuous=wrap("points", alpha=0.5))
            )

## @knitr 1iiGgpairs

chars %>%
    select(c(type, customers, rating, percentage.ic, feeders)) %>%
    ggpairs(mapping = ggplot2::aes(colour=type),
            legend=1,
            columns=2:5,
            upper=c(continuous=wrap("cor", size=2.5)),
            diag=list(continuous=wrap("barDiag")),
            lower=list(continuous=wrap("points", alpha=0.5))
    )
