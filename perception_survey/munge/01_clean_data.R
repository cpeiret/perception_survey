# clean the data
# duplicate df
clean_data = raw_data

# keep needed columns
variables = lapply(clean_data[colnames(clean_data)], var_lab) # see what each column means
clean_data = clean_data[,c(8,11:13,22,33,39,55,60:62,66:141)] # keep only needed columns

# remove DK/NA values from satisfaction questions
clean_data[,4:7] = dplyr::na_if(clean_data[,4:7], 5) # set DK/NA values as NA

# 

