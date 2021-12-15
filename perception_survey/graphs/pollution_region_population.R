# relationship between air pollution and other variables

# setting data up
city_data = clean_data %>% 
  select(cities, pm25_2015, eastern_europe, western_europe, northern_europe, southern_europe, 
         lez, inc, ideo, population, gdp_pc, pop_density, oldage_dependency, inequality, transparency) %>%
  group_by(cities) %>%
  summarise(pm25_2015 = mean(pm25_2015),
            eastern_europe = mean(eastern_europe),
            western_europe = mean(western_europe),
            northern_europe = mean(northern_europe),
            southern_europe = mean(southern_europe),
            lez = mean(lez),
            inc = mean(inc),
            ideo = mean(ideo),
            population = mean(population),
            gdp_pc = mean(gdp_pc),
            pop_density = mean(pop_density),
            oldage_dependency = mean(oldage_dependency),
            inequality = mean(inequality),
            transparency = mean(transparency)
            ) %>%
  pivot_longer(cols = c(eastern_europe, western_europe, northern_europe, southern_europe), names_to = "regions") %>%
  filter(value == 1) %>%
  select(-value) %>%
  mutate(population = population * 1000) %>%
  filter(population != 0)

# pollution vs population

pal = c("#264653", "#2A9D8F", "#E9C46A", "#E76F51")

ggplot(data = city_data, aes(x = gdp_pc, y = pm25_2015)) +
  geom_point(aes(colour = regions, size = population), alpha = 0.7) +
  scale_color_manual(values = pal, name = "Region", labels = c("Eastern Europe", "Northern Europe", "Southern Europe", "Western Europe")) +
  scale_size(range = c(1, 50), name = "Population", labels = scales::comma) +
  guides(colour = guide_legend(override.aes = list(size = 5)), size = guide_legend(override.aes = list(colour = "grey"))) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma, name = "GDP per capita in euros") +
  scale_y_continuous(name = "Annual average concentration of PM2.5 particles in μg/m3") +
  labs(
    title = "Relationship between urban pollution and GDP per capita and population",
    subtitle = "There is a clear negative relationship between air pollution and city wealth. There also seems to be a relationship between region and pollution, with cities from Eastern Europe showing higher levels of pollution, and Northern-European cities showing lower levels. 
The relationship between city size and pollution is not clear, as we see cities of all sizes scattered all over the spectrum of pollution levels."
  ) +
  theme(legend.text = element_text(size = 12),
        legend.title = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12))













