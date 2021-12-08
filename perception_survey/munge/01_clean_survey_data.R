# clean the data
# duplicate df
clean_data = raw_data

# keep needed columns
variables = lapply(raw_data[colnames(raw_data)], var_lab) # see what each column means
clean_data = clean_data[,c(8,11:13,22,33,39,55,57,60:62,66:98, 137:141)] # keep only needed columns
variables_clean = lapply(clean_data[colnames(clean_data)], var_lab) # see what each column means

# remove DK/NA values from satisfaction questions
clean_data[,4:7] = dplyr::na_if(clean_data[,4:7], "DK/NA  (DO NOT READ OUT)") # set DK/NA values as NA

# remove DK/NA values from demographic questions
clean_data$d14 = dplyr::na_if(clean_data$d14, "Refusal (DO NOT READ OUT)") # set DK/NA values as NA
clean_data$d1 = dplyr::na_if(clean_data$d1, "99 [ACCORDING TO d1r1: REFUSAL]") # set DK/NA values as NA
clean_data$d1r1 = dplyr::na_if(clean_data$d1r1, "Refusal") # set DK/NA values as NA
clean_data$d1r2 = dplyr::na_if(clean_data$d1r2, "Refusal") # set DK/NA values as NA
clean_data$d4 = dplyr::na_if(clean_data$d4, "DK") # set DK/NA values as NA
clean_data$d4 = dplyr::na_if(clean_data$d4, "Refusal") # set DK/NA values as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, "Refusal") # set DK/NA values as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, "DK") # set DK/NA values as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, "Refusal") # set DK/NA values as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, "DK") # set DK/NA values as NA
clean_data$d5 = dplyr::na_if(clean_data$d5, "Refusal") # set DK/NA values as NA
clean_data$d5r = dplyr::na_if(clean_data$d5r, "Refusal") # set DK/NA values as NA


# keep only complete cases
clean_data = clean_data[complete.cases(clean_data), ]

# see how many cases we have per city now
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city before cleaning

# rename variables
clean_data = clean_data %>% rename(
  public_transport = q1_1,
  air_quality = q1_10,
  cc_fight = q2_9,
  finance_household = q3_2,
  difficulty_bills = d14,
  train_commute = d21.2,
  public_transport_commute = d21.5,
  bycicle_commute = d21.6,
  walking_commute = d21.7,
  age = d1,
  age_4groups = d1r1,
  age_6groups = d1r2,
  gender = d2,
  education = d4,
  education_13groups = d4r1,
  education_5groups = d4r2
)

# create values for each label for satisfaction variables

clean_data = mutate(clean_data,
       public_transport_v = case_when(
         public_transport == "Very satisfied" ~ 4,
         public_transport == "Rather satisfied" ~ 3,
         public_transport == "Rather unsatisfied" ~ 2,
         public_transport == "Not at all satisfied" ~ 1,
         TRUE ~ NA_real_
       )
         )

clean_data = mutate(clean_data,
                    air_quality_v = case_when(
                      air_quality == "Very satisfied" ~ 4,
                      air_quality == "Rather satisfied" ~ 3,
                      air_quality == "Rather unsatisfied" ~ 2,
                      air_quality == "Not at all satisfied" ~ 1,
                      TRUE ~ NA_real_
                    )
)

clean_data = mutate(clean_data,
                    cc_fight_v = case_when(
                      cc_fight == "Strongly agree" ~ 4,
                      cc_fight == "Somewhat agree" ~ 3,
                      cc_fight == "Somewhat disagree" ~ 2,
                      cc_fight == "Strongly disagree" ~ 1,
                      TRUE ~ NA_real_
                    )
)

clean_data[,c(9:11, 17:45)] = lapply(clean_data[,c(9:11, 17:45)], unclass)








