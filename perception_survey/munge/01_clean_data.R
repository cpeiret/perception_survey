# clean the data
# duplicate df
clean_data = raw_data

# keep needed columns
variables = lapply(clean_data[colnames(clean_data)], var_lab) # see what each column means
clean_data = clean_data[,c(8,11:13,22,33,39,55,60:62,66:98, 137:141)] # keep only needed columns
variables_clean = lapply(clean_data[colnames(clean_data)], var_lab) # see what each column means

# remove DK/NA values from satisfaction questions
clean_data[,4:7] = dplyr::na_if(clean_data[,4:7], 5) # set DK/NA values as NA

# remove DK/NA values from demographic questions
clean_data$cities = dplyr::na_if(clean_data$cities, 84) # set DK/NA values as NA
clean_data$d14 = dplyr::na_if(clean_data$d14, 4) # set DK/NA values as NA
clean_data$d1 = dplyr::na_if(clean_data$d1, 99) # set DK/NA values as NA
clean_data$d1r1 = dplyr::na_if(clean_data$d1r1, 7) # set DK/NA values as NA
clean_data$d1r2 = dplyr::na_if(clean_data$d1r2, 7) # set DK/NA values as NA
clean_data$d4 = dplyr::na_if(clean_data$d4, 0) # set DK/NA values as NA
clean_data$d4 = dplyr::na_if(clean_data$d4, 99) # set DK/NA values as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, 97) # set DK/NA values as NA
clean_data$d4r1 = dplyr::na_if(clean_data$d4r1, 98) # set DK/NA values as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, 6) # set DK/NA values as NA
clean_data$d4r2 = dplyr::na_if(clean_data$d4r2, 7) # set DK/NA values as NA
clean_data$d5 = dplyr::na_if(clean_data$d5, 22) # set DK/NA values as NA
clean_data$d5r = dplyr::na_if(clean_data$d5r, 9) # set DK/NA values as NA

# keep only complete cases
clean_data<- clean_data[complete.cases(clean_data), ]

# see how many cases we have per city now
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # mean cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(max(n)) # max n of cases per city before cleaning
clean_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city after cleaning
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(min(n)) # min n of cases per city before cleaning
