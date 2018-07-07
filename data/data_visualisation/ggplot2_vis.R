## Data visualisation with ggplot2
## 25/01/2018



#   -----------------------------------------------------------------------
# Load packages -----------------------------------------------------------

library(readr)
library(dplyr)
library(ggplot2)


#   -----------------------------------------------------------------------
# Import data -------------------------------------------------------------

air_quality <- read_csv("./slides/data_visualisation/air-quality.csv")
weather <- read_csv("./slides/data_visualisation/hanoi_weather_history.csv")

air_quality <- air_quality %>%
    group_by(date, year, month, day) %>%
    summarise(avg_aqi = mean(aqi, na.rm = TRUE)) %>%
    ungroup() %>%
    left_join(select(weather, date, min_temp, max_temp, max_steady_wind, description))

air_quality <- air_quality %>%
    mutate(month = factor(month),
           year = factor(year),
           day = factor(day))


#   -----------------------------------------------------------------------
# Buid a plot layer by layer ----------------------------------------------


# data layer -------

ggplot(data = air_quality) # show no thing


# aesthetics layer -------

ggplot(data = air_quality, aes(x = min_temp, y = avg_aqi))

p1 <- ggplot(data = air_quality, aes(x = min_temp, y = avg_aqi))
p1


# geometric layer --------

p2 <- p1 + geom_point()

p2 <- p1 + geom_point(alpha = 0.6) # add transparency to reduce overplotting
p2


# facets layer ---------

p3 <- p2 + facet_wrap(facets = ~ month)
p3

# statistics layer ----------

p4 <- p3 + geom_smooth(method = "lm", se = FALSE, color = "red")
p4

# coordinates layer ---------

# zoom in
p5 <- p4 + coord_cartesian(xlim = c(5, 32),  ylim = c(25, 200))
p5


# theme layer -----------

p6 <- p5 + labs(x = "Min temp (C)", y = "AQI") +
    theme_minimal() +
    theme(strip.text = element_text(face = "bold"))
p6


# wrap-up ------------

ggplot(data = air_quality, aes(x = min_temp, y = avg_aqi)) +
    geom_point(alpha = 0.6) +
    facet_wrap(~ month) +
    geom_smooth(method = "lm", se = FALSE, color = "red") +
    coord_cartesian(xlim = c(5, 32),  ylim = c(25, 200)) +
    theme_minimal() +
    labs(x = "Min temp (C)", y = "AQI") +
    theme(strip.text = element_text(face = "bold"))


#   -----------------------------------------------------------------------
# Aesthetics mapping ------------------------------------------------------

# Your code goes here


#   -----------------------------------------------------------------------
# Geoms -------------------------------------------------------------------

# Your code goes here


#   -----------------------------------------------------------------------
# Facets ------------------------------------------------------------------

# Your code goes here

