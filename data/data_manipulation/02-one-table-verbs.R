

source("slides/data_manipulation/01-data.R")


# filter() ----------------------------------------------------------------


filter(air_quality, year == 2017, month == 1)

filter(air_quality, month %in% c(1, 2, 3))

filter(air_quality, hour >= 6 & hour <= 19)

filter(air_quality, aqi >= 201 & aqi <= 300)

filter(air_quality, aqi > mean(aqi, na.rm = TRUE))


# select() ----------------------------------------------------------------


select(air_quality, datetime:hour)

select(air_quality, contains("aqi"))

select(air_quality, starts_with("aqi"))

select(air_quality, aqi, aqi_categ)


# arrange() ---------------------------------------------------------------

arrange(air_quality, date, hour)

arrange(air_quality, year, month, day, hour)

arrange(air_quality, desc(aqi))


# mutate() ----------------------------------------------------------------

mutate(air_quality, is_good = aqi <= 50)

mutate(air_quality,
       aqi_color_code = ifelse(aqi <= 50, "green",
                        ifelse(aqi >= 51 & aqi <= 100, "yellow",
                        ifelse(aqi >= 101 & aqi <= 150, "orange",
                        ifelse(aqi >= 151 & aqi <= 200, "red",
                        ifelse(aqi >= 201 & aqi <= 300, "purple",
                        ifelse(aqi >= 301, "brown", NA))))))
           )

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


