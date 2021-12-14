# clean the data
# duplicate df
clean_data = raw_data

# keep only needed columns

clean_data = clean_data[,-c(1:7,9:10,14:21,23:32,34:38, 40:42,44:55,57:59,63:65,99:136,142:151)]

variables_clean = lapply(clean_data[colnames(clean_data)], var_lab) # see what each column means

# remove DK/NA values from satisfaction questions

clean_data$q1_1 = dplyr::na_if(clean_data$q1_1, 5) # recode DK/NA as NA
clean_data$q1_10 = dplyr::na_if(clean_data$q1_10, 5) # recode DK/NA as NA
clean_data$q2_9 = dplyr::na_if(clean_data$q2_9, 5) # recode DK/NA as NA
clean_data$d1r1 = dplyr::na_if(clean_data$d1r1, 7) # recode DK/NA as NA
clean_data$d1r2 = dplyr::na_if(clean_data$d1r1, 7) # recode DK/NA as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, 97) # recode DK/NA as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, 98) # recode DK/NA as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, 6) # recode DK/NA as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, 7) # recode DK/NA as NA
clean_data$q3_2 = dplyr::na_if(clean_data$q3_2, 5) # recode DK/NA as NA

clean_data = clean_data[complete.cases(clean_data),] # keep only complete cases
nrow(clean_data)/nrow(raw_data) * 100 # percentage of complete cases over total observations


# see how many cases we have per city now
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city before cleaning

# rename columns

clean_data = clean_data %>% rename(
  pt_satisfaction = q1_1,
  air_satisfaction = q1_10,
  cc_fight = q2_9,
  car_commute = d21_1,
  pt_commute = d21_5,
  bicyle_commute = d21_6,
  walk_commute = d21_7,
  age = d1,
  age_4g = d1r1,
  age_6g = d1r2,
  gender = d2,
  education = d4,
  education_11 = d4r1,
  education_5g = d4r2,
  occupation = d5,
  occupation_scale = d5r,
  financial_situation = q3_2,
  env_concern = q4_2
)

# recode satisfaction variables values

clean_data = mutate(clean_data,
                    pt_satisfaction = case_when(
                      pt_satisfaction == 1 ~ 4,
                      pt_satisfaction == 2 ~ 3,
                      pt_satisfaction == 3 ~ 2,
         pt_satisfaction == 4 ~ 1
       )
         )

add_val_lab(clean_data$pt_satisfaction) = num_lab("4 Very satisfied
                                                   3 Rather satisfied
                                                   2 Rather unsatisfied
                                                   1 Very unsatisfied
                                                   ")

clean_data = mutate(clean_data,
                    air_satisfaction = case_when(
                      air_satisfaction == 1 ~ 4,
                      air_satisfaction == 2 ~ 3,
                      air_satisfaction == 3 ~ 2,
                      air_satisfaction == 4 ~ 1,
                      TRUE ~ NA_real_
                    )
)

add_val_lab(clean_data$air_satisfaction) = num_lab("4 Very satisfied
                                                   3 Rather satisfied
                                                   2 Rather unsatisfied
                                                   1 Very unsatisfied
                                                   ")


clean_data = mutate(clean_data,
                    cc_fight = case_when(
                      cc_fight == 1 ~ 4,
                      cc_fight == 2 ~ 3,
                      cc_fight == 3 ~ 2,
                      cc_fight == 4 ~ 1,
                      TRUE ~ NA_real_
                    )
)

add_val_lab(clean_data$cc_fight) = num_lab("4 Very satisfied
                                                   3 Rather satisfied
                                                   2 Rather unsatisfied
                                                   1 Very unsatisfied
                                                   ")


clean_data = apply_labels(clean_data,
                          pt_satisfaction = "Satisfaction with public transport in the city",
                          air_satisfaction = "Satisfaction with air quality in the city",
                          cc_fight = "Satisfaction with the way the city fights climate change"
                          )

# create a column for gender
clean_data = transform(clean_data, female = ifelse(clean_data$gender == 2,1,0)) # value == 1 if female
clean_data = transform(clean_data, male = ifelse(clean_data$gender == 1,1,0)) # value == 1 if male

# create column for northern countries citizens



# add air pollution data
clean_data$cities = unlabelled(clean_data$cities) # remove labels from cities colum
clean_data$cities = sub(".*-","", clean_data$cities) # keep only cities' names
clean_data = merge(clean_data,OECD_Air_pollution[,c(3,11)], by.x = "cities", by.y = "city_name") # add 2015 pm2.5 data


# calculate perception gap
clean_data = within(clean_data, air_satisfaction_z <- ave(air_satisfaction, cities, FUN=scale)) # scale air quality perception by city groups

clean_data$pm25_2015_z = scale(clean_data$pm25_2015) # scale pollution data
clean_data$air_quality = -clean_data$pm25_2015_z # convert to air quality -> - pm25_2015

clean_data$gap = clean_data$air_satisfaction_z - clean_data$air_quality # relative gap
clean_data$gap_abs = abs(clean_data$air_satisfaction_z - clean_data$air_quality) # absolute gap

# create a variable for green means of transport

clean_data = mutate(clean_data,
       green_transport = case_when(
         pt_commute == 1 ~ 1,
         bicyle_commute == 1 ~ 1,
         walk_commute == 1 ~ 1,
         TRUE ~ 0
       ))

# add "LEZ", "incumbency" and "ideology" variables
clean_data = merge(clean_data, PRG_Database_12[,c(1,122:129)], by.x = "serialid", by.y = "serialid")

# add labels to variables
clean_data = apply_labels(clean_data,
                          female = "Gender is female",
                          male = "Gender is male",
                          pm25_2015 = "Average annual concentration of PM2.5 particles in g/m3 in 2015",
                          air_satisfaction_z = "Normalised satisfaction with air quality in the city (mean = city mean)",
                          pm25_2015_z = "Normalised average annual concentration of PM2.5 particles in g/m3 in 2015",
                          air_quality = "- pm25_2015",
                          
                          lez = "There was a low emissions zone operating in the city by 2015",
                          air_satisfaction = "Satisfaction with air quality in the city",
                          cc_fight = "Satisfaction with the way the city fights climate change"
)