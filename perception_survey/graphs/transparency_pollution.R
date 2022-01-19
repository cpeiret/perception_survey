
ggplot(data = city_data, aes(x = transparency, y = pm25_2015)) +
  geom_point(aes(colour = regions), alpha = 0.7, size = 6) +
  scale_color_manual(values = pal, name = "Region", labels = c("Eastern Europe", "Northern Europe", "Southern Europe", "Western Europe")) +
  scale_size(range = c(5, 50), name = "Population", labels = scales::comma) +
  guides(colour = guide_legend(override.aes = list(size = 5)), size = guide_legend(override.aes = list(colour = "grey"))) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma, name = "Transparency index (0-10)") +
  scale_y_continuous(name = "Annual average concentration of PM2.5 particles in μg/m3") +
  labs(
    title = "Relationship between urban pollution and transparency index",
    subtitle = "Cities located in countries with higher levels of transparency tend to show lower levels of pollution."
  ) +
  theme(legend.text = element_text(size = 12),
        legend.title = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12))


ggplot(data = clean_data, aes(x = transparency, y = gap)) +
  geom_point(alpha = 0.7, size = 6) +
  scale_color_manual(values = pal, name = "Region", labels = c("Eastern Europe", "Northern Europe", "Southern Europe", "Western Europe")) +
  scale_size(range = c(5, 50), name = "Population", labels = scales::comma) +
  guides(colour = guide_legend(override.aes = list(size = 5)), size = guide_legend(override.aes = list(colour = "grey"))) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma, name = "Transparency index (0-10)") +
  scale_y_continuous(name = "Relative gap") +
  labs(
    title = "Relationship between urban pollution and transparency index",
    subtitle = "Cities located in countries with higher levels of transparency tend to show lower levels of pollution."
  ) +
  theme(legend.text = element_text(size = 12),
        legend.title = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12))
