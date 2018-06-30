


library(readr)
library(dplyr)

air_quality <- read_csv("slides/data_manipulation/air-quality.csv")
weather <- read_csv("slides/data_manipulation/hanoi_weather_history.csv")

air_quality %>%
    group_by(date) %>%
    summarise(
        min_aqi = min(aqi, na.rm = TRUE),
        max_aqi = max(aqi, na.rm = TRUE),
        avg_aqi = mean(aqi, na.rm = TRUE)
    ) %>%
    left_join(weather, by = "date") -> airquality_by_date

airquality_by_date




