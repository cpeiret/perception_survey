# cleveland dot plot
# first prepare the data

plot_data = OECD_Air_pollution %>% select(c("city_name","pm25_2000","pm25_2015")) %>%
  pivot_longer(cols = c(pm25_2000, pm25_2015), values_to = "pm25") %>%
  rename(year = name) %>%
  arrange(pm25)

plot_data$city_name = factor(plot_data$city_name, levels = unique(plot_data$city_name))
  
right_label = plot_data %>%
  group_by(city_name) %>%
  arrange(desc(pm25)) %>%
  top_n(1)

left_label = plot_data %>%
  group_by(city_name) %>%
  arrange(desc(pm25)) %>%
  slice(2)


# create a df with differences

diff = plot_data %>%
  spread(year, pm25) %>%
  group_by(city_name) %>%
  mutate(Max = max(pm25_2000, pm25_2015),
         Min = min(pm25_2000, pm25_2015),
         Diff = Max / Min - 1) %>%
  arrange(desc(Diff)) %>%
  filter(Diff > 0.05)


highlight = filter(plot_data, city_name %in% diff$city_name)

plot_labels = diff %>%
  select(city_name, pm25 = Max, Diff) %>%
  right_join(right_label)

p = ggplot(plot_data, aes(pm25, city_name)) +
  geom_line(aes(group = city_name), alpha = .3) +
  geom_point(aes(color = year), size = 2, alpha = .3) +
  geom_line(data = highlight, aes(group = city_name)) +
  geom_point(data = highlight, aes(colour = year), size = 2) +
  geom_text(data = plot_labels, aes(colour = year, 
                                   label = paste0("-", scales::percent(round(Diff,1)))),
            size = 3, hjust = -.5) +
  scale_color_grey()


diff = diff %>%
  mutate(city_name = fct_reorder(city_name, desc(Diff)))
  
p2 = p + scale_color_discrete(labels = c("2000", "2015")) +
  scale_x_continuous(limits = c(5.9,40),
                     breaks = seq(0,40, by = 5)) +
  scale_y_discrete(expand = c(0.02, 0)) +
  labs(title = "Evolution of PM2.5 annual average concentration", 
       subtitle = "blah, blah, blah") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.justification = c(0,1),
        legend.position = c(.1, 1.075),
        legend.background = element_blank(),
        legend.direction = "horizontal",
        text = element_text(family = "Tahoma"),
        plot.title = element_text(size = 20, margin = margin(b = 10)),
        plot.subtitle = element_text(size = 10, margin = margin(b = 25)),
        plot.caption = element_text(size = 8, margin = margin(t = 10), color = "grey70", hjust = 0),
        axis.text = element_text(size = 8))
p2
