# calculate gap
CleanData$RelGap = CleanData$AirSatStd - CleanData$AirQStd # relative gap
CleanData$AbsGap = abs(CleanData$RelGap)# absolute gap
