pacman::p_load(       
  tidyverse,
  janitor,
  skimr,
  kableExtra,
  flextable
)
emdat <- read.csv("EMDAT.csv")
glimpse(emdat)
str(emdat)
skim(emdat)
view(emdat)
affected <- clean_names(emdat) %>%
  select("entity", "year", "deaths_all_disasters", "injured_all_disasters", "homeless_all_disasters")
view(affected)
avg_dih <- affected %>%
  group_by(entity) %>%
  summarize(
    avg_deaths = mean(deaths_all_disasters, na.rm = TRUE) %>% round(2),
    avg_injured = mean(injured_all_disasters, na.rm = TRUE) %>% round(2),
    avg_homeless = mean(homeless_all_disasters, na.rm = TRUE) %>% round(2)
  )
view(avg_dih)
avg_deaths_ranked = avg_dih %>%
  select(entity, avg_deaths) %>%
  arrange(desc(avg_deaths)) %>%
  slice(1:11)
avg_deaths_ranked_table <- kable(avg_deaths_ranked) %>%
  kable_styling()
avg_injured_ranked_table <- kable(
  avg_dih %>%
    select(entity, avg_injured) %>%
    arrange(desc(avg_injured)) %>%
    slice(1:11)
) %>%
  kable_styling()
avg_injured_ranked_table
avg_homeless_ranked_table <- kable(
  avg_dih %>%
    select(entity, avg_homeless) %>%
    arrange(desc(avg_homeless)) %>%
    slice(1:11)
) %>%
  kable_styling()
avg_homeless_ranked_table
emdat_deadly <- clean_names(emdat) %>%
  select(entity, year, deaths_all_disasters) %>%
  mutate(
    deadly = ifelse(deaths_all_disasters > 500, 1, 0)
  )
view(emdat_deadly)
affected_wider <- affected %>%
  pivot_wider(
    names_from = entity,
    values_from = c(deaths_all_disasters, injured_all_disasters, homeless_all_disasters)
  )
view(affected_wider)