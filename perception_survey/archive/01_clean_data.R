# we'll add variables step by step

clean_data = raw_data %>%
  select(serialid, cities, q1_10) %>% # select only satisfaction with air quality
  rename(sat_air = q1_10) %>% # recode so we have a nice ordinal variable
  mutate(
    sat_air = case_when(
      sat_air == "Very satisfied" ~ 4,
      sat_air == "Rather satisfied" ~ 3,
      sat_air == "Rather unsatisfied" ~ 2,
      sat_air == "Not at all satisfied" ~ 1,
      TRUE ~ NA_real_
    )
  ) %>%
  na.omit() # omit NAs
