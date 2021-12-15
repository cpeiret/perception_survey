city_data$lez = factor(city_data$lez)

ggplot(data = city_data, aes(x = lez, y = pm25_2015)) +
  geom_violin(aes(fill = lez), trim = FALSE) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values = c("#00AFBB","#FC4E07"), name = element_blank(), labels = c("No LEZ in the city","LEZ operating in the city")) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    legend.text = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
scale_y_continuous(name = "Annual average concentration of PM2.5 particles in μg/m3") +
  labs(
    title = "Average pollution in cities with and without low emissions zones.",
    subtitle = "On average, cities where a LEZ operates seem to show a slightly lower levels of pollution."
  )
  
