rm(list = ls())
library(tidyverse)
emdat <- read.csv("EMDAT.csv")
glimpse(emdat)
str(emdat)
view(emdat)
emdat_renamed <- emdat %>%
  rename(
    entity = Entity, 
    year = Year)
affected <- emdat_renamed %>%
  select("entity", "year", "deaths_all_disasters", "injured_all_disasters", "homeless_all_disasters")
view(affected)
str(affected)
deaths_total_per_country <- affected %>%
  select("entity", "year", "deaths_all_disasters") %>%
  pivot_wider(
    names_from = entity,
    values_from = deaths_all_disasters
  )
view(deaths_total_per_country)
deaths_mean_per_country <- deaths_total_per_country %>%
  colMeans(na.rm=TRUE) %>%
  round(2)
deaths_mean_per_country_df <- as.data.frame(deaths_mean_per_country) %>%
  arrange(desc(deaths_mean_per_country))
deaths_mean_per_country_df

