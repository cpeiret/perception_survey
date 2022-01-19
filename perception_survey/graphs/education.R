plot_data = clean_data %>% select("air_satisfaction_z", "education_5g")
plot_data = plot_data %>%
  filter(education_5g != "DK",
         education_5g != "Refusal")

ggplot(data = plot_data, aes(x = education_5g, y = air_satisfaction_z)) +
  geom_violin(aes(fill = education_5g), trim = FALSE) +
  geom_boxplot(width = 0.2) +
  scale_fill_manual(values = c( "#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"), name = element_blank(), labels = c("Up to 15 years", "16-19 years", "20 years and more", "Still studying", "No full-time education")) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    legend.text = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  scale_y_continuous(name = "Satisfaction with air quality in the city (standardised values)") +
  labs(
    title = "Differences between satisfaction with air quality by education level",
    subtitle = ""
  )



plot_data %>% group_by(education_5g) %>%
  summarise(mean = mean(air_satisfaction_z))
