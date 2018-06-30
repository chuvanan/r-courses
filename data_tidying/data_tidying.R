

library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

# install.packages("ggmap")
library(ggmap)



# diem thi ----------------------------------------------------------------

diemthi <- read_csv("slides/data_tidying/diemthi_tslop10.csv")

diemthi

diemthi_tidy <- gather(diemthi, key = "mon", value = "diem",
                       van, ngoaingu, toan)
diemthi_tidy


# your turn: forest_fires.csv




# airport gps -------------------------------------------------------------

airport_gps <- read_csv("slides/data_tidying/airports_gps.csv")

airport_gps

airport_gps_tidy <- separate(airport_gps,
                             col = "gps",
                             into = c("lon", "lat"),
                             sep = "/")

airport_gps_tidy

# bonus

airport_gps_tidy$lon <- as.double(airport_gps_tidy$lon)
airport_gps_tidy$lat <- as.double(airport_gps_tidy$lat)

vnm <- get_map("vietnam", zoom = 5)

ggmap(vnm) +
    geom_point(data = airport_gps_tidy,
               aes(lon, lat),
               color = "brown", size = 3)

# your turn: oecd_teacher_salary.csv




# toy example 3 -----------------------------------------------------------

sales_kpi <- read_csv("slides/data_tidying/sales_kpi.csv")

sales_kpi <- gather(sales_kpi, key = "quater", value = "amount", q1:q4)

sales_kpi <- unite(sales_kpi, col = "period",
                   month, year, sep = "/", remove = FALSE)

sales_kpi <- spread(sales_kpi, key = "kpi", value = "amount")

sales_kpi <- mutate(sales_kpi, quater = gsub("q", "", quater))

sales_kpi

# your turn: hanoi_temp_wideform.csv



# final challenge ---------------------------------------------------------

dat <- read_csv("slides/data_tidying/so3.csv")
dat

# expected output:

#   Person Pre.Score1 Pre.Score2 Pre.Score3  Post.Score1 Post.Score2 Post.Score3
# 1   greg         80         78       84.0           79          80        84.5
# 2  sally         75         74       79.5           78          78        83.0
# 3    sue         81         78       84.5           82          81        86.5

# your solution goes here:



