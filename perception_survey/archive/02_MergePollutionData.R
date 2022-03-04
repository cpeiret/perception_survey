# add air pollution data to satisfaction data
CleanData = merge(CleanData, air_pollution[,c('city_name', 'pm2.5')], by.x = 'City', by.y = 'city_name')

# convert air pollution to air quality
CleanData$AirQ = -CleanData$pm2.5

# rearrange column order
CleanData = CleanData[,c(2,3.1,3:5)]
