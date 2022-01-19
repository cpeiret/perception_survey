# relationship between pollution and perception

plot_data = clean_data %>% select("air_satisfaction_z", "air_quality")

ggplot(plot_data, aes(x = air_quality, y = air_satisfaction_z )) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(
    title = "Air quality in the city and satisfaction with air quality",
    subtitle = "There seems to be a linear relationship between satisfaction with air quality and real air quality."
  ) +
  scale_x_continuous(name = "Air quality in the city (standardised values)") +
  scale_y_continuous(name = "Satisfaction with air quality in the city (standardised values)")
