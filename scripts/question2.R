# Code for question2

## @knitr 2.init

daily.avg <- data.2013 %>%
    select(-date) %>%
    group_by(substation) %>%
    summarise_all(median) %>%
    # summarise_all(mean) %>%
    column_to_rownames(var="substation")
    

medians <- daily.avg %>%
    apply(2, median)
    
mads <- daily.avg %>%
    apply(2, mad)

scaled <- daily.avg %>%
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

## @knitr 2.i.dist

data.dist <- dist(scaled)


## @knitr 2.i.dend.plot

data.hc = hclust(data.dist)

plot(data.hc, hang=-1)


## @knitr 2.ii.clusters

data.groups <- cutree(data.hc, 7) %>%
# data.groups <- cutree(data.hc, 18) %>%
    enframe(name="substation", value="group") %>%
    mutate(substation=as.integer(substation))

data.2013.grouped <- data.2013 %>%
    merge(data.groups, by="substation", all.x=TRUE) %>%
    relocate(group, .after=date)

daily.grouped <- daily.avg %>%
    rownames_to_column("substation") %>%
    merge(data.groups, by="substation", all.x=TRUE) %>%
    relocate(group, .after=substation) 


## @knitr 2.iii.alldays

# 1. Filter by day
# 2. groupby cluster
# 4. scatter plot for each cluster,
#    x=time of day, 

# data.2013 %>%
#     ggplot(aes())

daily.grouped %>%
    # filter(group==1) %>%
    gather("time", "demand", -c(substation, group)) %>%
    mutate(hour=as.numeric(time)/6) %>%
    group_by(substation) %>%
    mutate(demand.n=(demand-min(demand))/(max(demand)-min(demand))) %>%
    
    ggplot(aes(x=hour, y=demand)) +
    geom_point(size=0.1, alpha=0.1, color='red') +
    scale_x_continuous(breaks=seq(0, 24, 6),
                       minor_breaks=seq(0, 24, 1),
                       limits=c(0, 24)) +
    facet_wrap(~group)
