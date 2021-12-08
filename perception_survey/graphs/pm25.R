ggplot(OECD_Air_pollution, aes(x = seq_along(pm25_2015), y = pm25_2015, label = city_name)) +
  geom_point() +
  geom_label_repel() +
  theme_bw() +
  ggtitle("Pollution levels in 62 European cities, 2015") +
  xlab("Cities") +
  ylab("Average annual PM2.5 concentration (µg/m3)") +
  scale_x_discrete(labels = OECD_Air_pollution$city_name)


ggplot(OECD_Air_pollution, aes(x = seq_along(pm25_2015), y = pm25_2015, label = city_name, colour = isocntry)) +
  geom_point() +
  geom_label_repel() +
  theme_bw() +
  ggtitle("Pollution levels in 62 European cities, 2015") +
  xlab("Cities") +
  ylab("Average annual PM2.5 concentration (µg/m3)") +
  scale_x_discrete(labels = OECD_Air_pollution$city_name) +
  labs(colour = "Country")


nb.colours = length(unique(OECD_Air_pollution$isocntry))
mycolors <- colorRampPalette(brewer.pal(8, "Set2"))(nb.colours)

plot = ggplot(OECD_Air_pollution, aes(x = seq_along(pm25_2015), y = pm25_2015, colour = isocntry)) +
  geom_point(size = 4) +
  scale_color_manual(values = mycolors) +
  ggtitle("Pollution levels in 62 European cities, 2015") +
  xlab("Cities") +
  ylab("Average annual PM2.5 concentration (µg/m3)") +
  labs(colour = "Country") +
  scale_x_discrete(labels = cities) +
  theme_bw() +
  add_trace(y = )

ggplotly(plot)




