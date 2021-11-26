ggplot(air_pollution, aes(x = seq_along(pm10), y = pm10, label = city_name)) +
  geom_point() +
  geom_label() +
  theme_bw() +
  ggtitle("Pollution levels in 76 European cities, 2015") +
  ylab("PM10 concentration") +
  scale_x_discrete(labels = air_pollution$city_name)
