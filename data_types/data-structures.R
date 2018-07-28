

library(forcats)
library(ggplot2)
library(dplyr)
setwd("~/Documents/r-courses/data_types/")

air_quality <- read.csv("air-quality.csv")
diemthi <- readr::read_csv("THPT 2018 Quoc gia.csv")
str(air_quality$aqi_categ)
levels(air_quality$aqi_categ)


# Change level order ------------------------------------------------------

by_categ <-  filter(air_quality, !is.na(aqi_categ))
by_categ <- mutate(by_categ,
                   aqi_categ = fct_rev(fct_infreq(aqi_categ)))

ggplot(by_categ, aes(aqi_categ)) +
    geom_bar()

# Change factor level -----------------------------------------------------

by_categ <-  filter(air_quality, !is.na(aqi_categ))

by_categ <- mutate(by_categ,
                   aqi_categ = fct_collapse(aqi_categ,
                        Acceptalbe = c("Good", "Moderate"),
                        Dangerous = c("Unhealthy", "Unhealthy for Sensitive Groups"),
                        Deadly = c("Very Unhealthy", "Hazardous")
                   ))

by_categ$aqi_categ <- fct_relevel(by_categ$aqi_categ, "Acceptalbe", "Dangerous")

ggplot(by_categ, aes(aqi_categ)) +
    geom_bar()


# Patterned vectors -------------------------------------------------------


# Exercise 1

m <- 1:12
m <- ifelse(nchar(m) == 1, paste0("0", m), m)
y <- 2012:2018

paste0(
    rep(m, times = length(y)), "/",
    rep(y, each = 12)
    )





