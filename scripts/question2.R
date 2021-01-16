# Code for question2

## @knitr 2.init

daily.avg <- data.2013 %>%
    select(-date) %>%
    group_by(substation) %>%
    summarise_all(median)
    # summarise_all(mean)

medians <- daily.avg %>%
    select(-substation) %>%
    apply(2, median)
    
mads <- daily.avg %>%
    select(-substation) %>%
    apply(2, mad)

scaled <- daily.avg %>%
    select(-substation) %>%
    scale(center=medians, scale=mads)

# means <- daily.avg %>%
#     select(-substation) %>%
#     apply(2, mean)
# 
# sds <- daily.avg %>%
#     select(-substation) %>%
#     apply(2, sd)
# 
# scaled_mean <- daily.avg %>%
#     select(-substation) %>%
#     scale(center=means, scale=sds)

## @knitr 2.raw.smrs

dist(scaled)
