

source("data_manipulation/01-data.R")


# filter() ----------------------------------------------------------------


filter(air_quality, year == 2017, month == 1)

filter(air_quality, month %in% c(1, 2, 3))

filter(air_quality, hour >= 6 & hour <= 19)

filter(air_quality, aqi >= 201 & aqi <= 300)

filter(air_quality, aqi > mean(aqi, na.rm = TRUE))


# select() ----------------------------------------------------------------

# Q1 ----------------------------------------------------------------------

air_quality %>%
    group_by(year, month) %>%
    summarise(mean = mean(aqi, na.rm = TRUE))

air_quality %>%
    filter(year == 2017) %>%
    group_by(month) %>%
    summarise(avg_aqi = mean(aqi, na.rm = TRUE))

weather %>%
    mutate(month = as.character(lubridate::month(date)),
           year = lubridate::year(date)) %>%
    filter(year == 2017) %>%
    group_by(month) %>%
    summarise(avg_temp = mean(max_temp, na.rm = TRUE))

# ---------------------------------------

select(air_quality, datetime:hour)

select(air_quality, contains("aqi"))

select(air_quality, starts_with("aqi"))

select(air_quality, aqi, aqi_categ)


# arrange() ---------------------------------------------------------------

arrange(air_quality, date, hour)

arrange(air_quality, year, month, day, hour)

arrange(air_quality, desc(aqi))


# mutate() ----------------------------------------------------------------

x <- mutate(air_quality, is_good = aqi <= 50)


air_quality <- mutate(air_quality,
       aqi_color_code = case_when(
           aqi <= 50 ~ "green",
           aqi >= 51 & aqi <= 100 ~ "yellow",
           aqi >= 101 & aqi <= 150 ~ "orange",
           aqi >= 151 & aqi <= 200 ~ "red",
           aqi >= 201 & aqi <= 300 ~ "purple",
           aqi >= 301 ~ "brown"
       ))
















View(x)

air_quality %>%
    summarise(avg_aqi = mean(aqi, na.rm = TRUE))


air_quality %>%
    group_by(year, month) %>%
    summarise(avg_aqi = mean(aqi, na.rm = TRUE),
              min_aqi = min(aqi, na.rm = TRUE),
              max_aqi = max(aqi, na.rm = TRUE))



# summarise() -------------------------------------------------------------

by_year_month <- group_by(air_quality, year, month)

summarise(by_year_month, n())

summarise(by_year_month,
          avg_aqi = mean(aqi, na.rm = TRUE),
          sd_aqi = sd(aqi, na.rm = TRUE))

by_hour <- group_by(air_quality, hour)

summarise(by_hour,
          max_aqi = max(aqi, na.rm = TRUE),
          min_aqi = min(aqi, na.rm = TRUE))
