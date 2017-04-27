library(tidyverse); library(readxl)
library(hud)

Data <- hud::extract()

#Transform
Data <- filter(Data, program == 1 & rent_per_month > 0) %>%
  select(geotype, geoid, year, rent_per_month) %>%
  filter(year == 2015)

saveRDS(Data, "inst/example/Data.rda")
