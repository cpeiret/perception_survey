sjlabelled::get_labels(raw_data) # get labels of the variables

head(raw_data$d4)

# some interesting figures ------------------------------------------------

# about the survey
length(unique(raw_data$cities)) # number of cities in the study
nrow(raw_data) # individual responses
raw_data %>% group_by(cities) %>% count() %>% ungroup() %>% summarise(mean(n)) # average responses per city

# about the interviewees
mean(raw_data$d1) # average age
prop.table(table(raw_data$d2)) # proportion of men/women
