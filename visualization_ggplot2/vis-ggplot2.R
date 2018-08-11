
library(tidyr)
library(dplyr)
library(ggplot2)
library(patchwork)



# CPI ---------------------------------------------------------------------

cpi <- data.frame(
    year = 2010:2017,
    cpi = c(8.25, 12.79, 15.95, 6.91, 4.83, 0.74, 1.25, 4.96)
)

ggplot(cpi, aes(year, cpi)) +
    geom_line(size = 2, color = "#40655e") +
    geom_point(size = 4, color = "#40655e") +
    labs(title = "CPI quý I/2017 tăng cao nhất trong 3 năm qua") +
    scale_x_continuous(name = NULL,
                       breaks = 2010:2017,
                       labels = c("Q1/2010", paste0("'", 11:17))) +
    scale_y_continuous(name = NULL,
                       breaks = cpi$cpi,
                       labels = paste0(cpi$cpi, "%")) +
    theme(panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank())


# Health index ------------------------------------------------------------

health_index <- data.frame(
    country = c("Italy", "Iceland", "Thụy Sĩ", "Singapore", "Australia",
                "Tây Ban Nha", "Nhật Bản", "Thụy Điển", "Isarel", "Luxembourg"),
    score = c(93.11, 91.21, 90.75, 90.23, 89.24, 89.19, 89.15, 88.92, 88.14, 87.87),
    stringsAsFactors = FALSE
)

health_index <- health_index %>%
    mutate(country = forcats::fct_reorder(country, score))

ggplot(health_index,
       aes(country, score)) +
    geom_col() +
    labs(x = NULL, y = NULL,
         title = "Truncated axis") +
    coord_flip(ylim = c(87, 94)) -> none_zero_baseline

ggplot(health_index,
       aes(country, score)) +
    geom_col() +
    labs(x = NULL, y = NULL,
         title = "Full-scale axis") +
    coord_flip() -> zero_baseline

none_zero_baseline + zero_baseline


# Gasoline price --------------------------------------------------------------

gasoline_price <- data.frame(
    date = c("2016-09-20", "2016-10-05", "2016-10-20", "2016-11-04", "2016-11-19",
             "2016-12-20", "2017-02-18", "2017-03-06", "2017-03-21", "2017-04-05"),
    price = c(16232, 16404, 16845, 16892, 16374, 17594, 18098, 18018, 17314, 17234),
    stringsAsFactors = FALSE
)

gasoline_price$date <- as.Date(gasoline_price$date)

ggplot(gasoline_price, aes(date, price)) +
    geom_point() +
    geom_step() +
    labs(title = "Biểu đồ giá xăng") +
    scale_x_date(name = NULL,
                 breaks = gasoline_price$date) +
    scale_y_continuous(name = NULL,
                       breaks = seq(16500, 18000, 500),
                       labels = c("16,500", "17,000", "17,500", "(VND)\n18,000")) +
    theme(axis.text.x = element_text(angle = 45, vjust = 0.5),
          panel.grid.minor = element_blank())


# Lie factor --------------------------------------------------------------

env_tax <- data.frame(
    year = 2012:2016,
    revenue = c(11.2, 11.5, 11.9, 27, 41.9),
    spending = c(9, 9.7, 9.9, 11.4, 12.3)
)

env_tax <- env_tax %>%
    gather(type, amount, -year)

ggplot(env_tax, aes(year, amount, color = type)) +
    geom_line() +
    geom_point() +
    labs(x = NULL, y = NULL,
         title = "Thu và Chi Thuế Bảo Vệ Môi Trường",
         subtitle = "Đơn vị: nghìn tỷ đồng",
         caption = "Nguồn dữ liệu: Vnexpress/Infographics") +
    scale_color_manual(name = NULL, values = c("#9c954d", "#b067a3"))


# GII Index ---------------------------------------------------------------


