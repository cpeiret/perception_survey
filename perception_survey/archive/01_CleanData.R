# keep only needed columns for air satisfaction analysis
satisfaction = raw_data[,c(8,12,22)]

# separate city name from country name
satisfaction$Country = substr(satisfaction$cities, 1,2)
satisfaction$City = substr(satisfaction$cities,5,10000)

# rename column
satisfaction = rename(satisfaction, AirSat = q1_10)

# recode satisfaction values
satisfaction <-
  satisfaction %>% mutate(AirSat = case_when(
    AirSat ==  'Very satisfied' ~ 4,
    AirSat ==  'Rather satisfied' ~ 3,
    AirSat ==  'Rather unsatisfied' ~ 2,
    AirSat ==  'Not at all satisfied' ~ 1))

# remove NAs

(length(which(is.na(satisfaction$AirSat))) / length(satisfaction$AirSat)) * 100 # see proportion of NAs over sample
satisfaction = na.omit(satisfaction) # remove missing values

# rearrange columns and remove redundant ones
satisfaction = satisfaction[,c(1,4,5,3)]
