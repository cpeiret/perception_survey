city_ctry = unique(clean_data$cities)
city_ctry = as.data.frame(city_ctry)
city_ctry$isocntry = substr(city_ctry$city_ctry, 1,2)
city_ctry$city_name = substr(city_ctry$city_ctry, 5,1000)
city_ctry = city_ctry[,c(2,3)]

air_pollution = merge(air_pollution,city_ctry,by.x = "city_name", by.y = "city_name")
air_pollution = air_pollution[,c(5,1:4)]
air_pollution = air_pollution[order(air_pollution$isocntry),]

OECD_Air_pollution$isocntry = substr(OECD_Air_pollution$code,1,2)
