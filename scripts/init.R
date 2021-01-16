# Initialisation script

## @knitr 0.load_data

library(tidyverse)
library(here)

# Variable data

load(here::here("data/January_2013.RData"))

data.2013 <- January_2013 %>%
    rename(date=Date, substation=Substation)

rm(January_2013)

# Fixed data

chars <- read.csv(here::here("data/Characteristics.csv"), 
                  stringsAsFactors=FALSE) %>%
    rename(substation=SUBSTATION_NUMBER,
           customers=TOTAL_CUSTOMERS,
           type=TRANSFORMER_TYPE,
           rating=Transformer_RATING,
           percentage.ic=Percentage_IC,
           lv.feeder.count=LV_FEEDER_COUNT,
           grid.ref=GRID_REFERENCE) %>%
    mutate(type=replace(type,
                        type=="Grd Mtd Dist. Substation",
                        "Ground")) %>%
    mutate(type=replace(type,
                        type=="Pole Mtd Dist. Substation",
                        "Pole"))
