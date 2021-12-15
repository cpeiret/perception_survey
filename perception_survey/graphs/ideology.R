city_data$ideo = factor(city_data$ideo)

ggplot(data = city_data, aes(x = ideo, y = pm25_2015)) +
  geom_violin(aes(fill = ideo), trim = FALSE) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values = c("#00AFBB","#FC4E07"), name = element_blank(), labels = c("Conservative","Progressive")) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    legend.text = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  scale_y_continuous(name = "Annual average concentration of PM2.5 particles in μg/m3") +
  labs(
    title = "Average pollution in cities and city ruling party's ideology.",
    subtitle = "City ruling party's ideology does not seem to have a big effect on average pollution levels."
  )
