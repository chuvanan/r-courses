

library(readr)
library(dplyr)


air_quality <- read_csv("slides/data_manipulation/air-quality.csv")
weather <- read_csv("slides/data_manipulation/hanoi_weather_history.csv")

by_date <- group_by(air_quality, date)

airquality_by_date <- summarise(
    by_date,
    min_aqi = min(aqi, na.rm = TRUE),
    max_aqi = max(aqi, na.rm = TRUE),
    avg_aqi = mean(aqi, na.rm = TRUE)
)

airquality_by_date <- left_join(airquality_by_date, weather, by = "date")

