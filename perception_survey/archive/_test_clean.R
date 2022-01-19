sat = raw_data %>% select(,c(serialid, isocntry, cities, q1_1:q1_12, q2_1:q2_12, q3_1:q3_4)) # variables related to satisfaction

sat = sat %>%  # rename columns
  rename(
    sat_publictransport = q1_1,
    sat_healthcare = q1_2,
    sat_sport = q1_3,
    sat_culture = q1_4,
    sat_builtenv = q1_5,
    sat_publicspace = q1_6,
    sat_green = q1_7,
    sat_retail = q1_8,
    sat_education = q1_9,
    sat_air = q1_10,
    sat_noise = q1_11,
    sat_clean = q1_12,
    
    sat_city = q2_1,
    sat_jobmarket = q2_2,
    sat_foreigners1 = q2_3,
    sat_foreigners2 = q2_4,
    sat_housing = q2_5,
    sat_admin1 = q2_6,
    sat_safety = q2_7,
    sat_neighb1 = q2_8,
    sat_ccfight = q2_9,
    sat_people = q2_10,
    sat_neighb2 = q2_11,
    sat_admin2 = q2_12,
    
    sat_jobsit = q3_1,
    sat_financial = q3_2,
    sat_life = q3_3,
    sat_place = q3_4
  ) 

sat$cities = sub(".*-", "", sat$cities) # keep only cities' names
sat[,which(colnames(sat) == "sat_publictransport"):which(colnames(sat) == "sat_place")][sat[,which(colnames(sat) == "sat_publictransport"):which(colnames(sat) == "sat_place")] == "DK/NA (DO NOT READ OUT)"] = NA # recode NA values
sat[,which(colnames(sat) == "sat_publictransport"):which(colnames(sat) == "sat_place")][sat[,which(colnames(sat) == "sat_publictransport"):which(colnames(sat) == "sat_place")] == "DK/NA  (DO NOT READ OUT)"] = NA # recode NA values (there are still some left!)

apply(sat, 2, function(col)round(100*sum(is.na(col))/length(col),2)) # calculate percentage of NAs per column and remove those with high levels of NAs
sat = sat[,-c(which(colnames(sat) == "q3_1b"))] # remove columns with high level of NAs (>20%)

# recode variable labels






