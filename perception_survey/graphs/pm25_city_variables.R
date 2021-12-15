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
  mutate(population = population * 1000)

# pollution vs population

pal = c("#264653", "#2A9D8F", "#E9C46A", "#E76F51")

ggplot(data = city_data, aes(x = gdp_pc, y = pm25_2015)) +
  geom_point(aes(colour = regions, size = population), alpha = 0.7) +
  scale_color_manual(values = pal) +
  scale_size(range = c(1, 20))













