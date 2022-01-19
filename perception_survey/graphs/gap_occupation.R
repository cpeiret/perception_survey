plot_data = clean_data %>% select("gap", "occupation")
plot_data = plot_data %>%
  filter(education_5g != "DK",
         education_5g != "Refusal")

ggplot(data = plot_data, aes(x = occupation, y = gap)) +
  geom_violin(aes(fill = occupation), trim = FALSE) +
  geom_boxplot(width = 0.2) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    legend.text = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  ) +
  scale_y_continuous(name = "Perception gap") +
  labs(
    title = "Perception gap by occupation",
    subtitle = ""
  )



plot_data %>% group_by(occupation) %>%
  summarise(mean = mean(gap)) %>%
  sort_desc(mean) %>%
  print(n = 22) 
