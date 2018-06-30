
library(readr)
library(dplyr)

air_quality <- read_csv("./slides/data_manipulation/air-quality.csv")

weather <- read_csv("./slides/data_manipulation/hanoi_weather_history.csv")

table(air_quality$aqi_categ)

str(air_quality)

head(air_quality)

str(weather)

head(weather)

tail(weather)

