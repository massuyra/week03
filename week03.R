library(tidyverse)
emdat <- read.csv("EMDAT.csv")
glimpse(emdat)
view(emdat)
emdat %>%
  select(contains("deaths"||"injured"||"homeless"))
