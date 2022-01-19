plot_data = clean_data %>% select("air_satisfaction_z", "gender")

ggplot(data = plot_data, aes(x = gender, y = air_satisfaction_z)) +
  geom_violin(aes(fill = gender), trim = FALSE) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values = c("#00AFBB","#FC4E07"), name = element_blank(), labels = c("Men","Women")) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    legend.text = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  scale_y_continuous(name = "Satisfaction with air quality in the city (standardised values)") +
  labs(
    title = "Differences between satisfaction with air quality by gender",
    subtitle = ""
  )