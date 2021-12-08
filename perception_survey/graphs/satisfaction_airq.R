# satisfaction with air quality by age groups
ggplot(clean_data, aes(x = factor(air_quality), fill = age_6groups)) +
  geom_bar(position = "dodge") +
  theme_bw() +
  # labels
  ggtitle("Satisfaction with air quality by age groups") +
  xlab("") +
  ylab("Counts") +
  labs(fill = "Age group") +
  #format colours
  scale_fill_manual(values = c("#DD8D29", "#E2D200", "#46ACC8", "#94bf64", "#7c8f82", "#B40F20"))


# satisfaction distribution by city
