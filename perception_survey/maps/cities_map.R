# get lon and lat for each city

nrow = nrow(OECD_Air_pollution)
counter = 1

OECD_Air_pollution$lon[counter] = 0
OECD_Air_pollution$lat[counter] = 0

while (counter <= nrow){
  CityName <- gsub(' ','%20',OECD_Air_pollution$city_name[counter]) #remove space for URLs
  CountryCode <- OECD_Air_pollution$isocntry[counter]
  url <- paste(
    "http://nominatim.openstreetmap.org/search?city="
    , CityName
    , "&countrycodes="
    , CountryCode
    , "&limit=9&format=json"
    , sep="")
  x <- fromJSON(url)
  if(is.vector(x)){
    OECD_Air_pollution$lon[counter] <- x[[1]]$lon
    OECD_Air_pollution$lat[counter] <- x[[1]]$lat    
  }
  counter <- counter + 1
}

OECD_Air_pollution[,c("lon","lat")] = lapply(OECD_Air_pollution[,c("lon","lat")], as.numeric)

# map them

map(database= "world", col="grey80", fill=TRUE)



lon <- c(-72, -66, -107, -154)  #fake longitude vector
lat <- c(81.7, 64.6, 68.3, 60)  #fake latitude vector
coord <- mapproject(lon, lat, proj="gilbert", orientation=c(90, 0, 225))  #convert points to projected lat/long
points(coord, pch=20, cex=1.2, col="red")  #plot converted points