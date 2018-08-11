
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
    gather(type, amount, -year) %>%
    mutate(type = case_when(
        type == "revenue" ~ "Thu",
        type == "spending" ~ "Chi",
    ))

ggplot(env_tax, aes(year, amount, color = type)) +
    geom_line() +
    geom_point() +
    labs(x = NULL, y = NULL,
         title = "Thu và Chi Thuế Bảo Vệ Môi Trường",
         subtitle = "Đơn vị: nghìn tỷ đồng",
         caption = "Nguồn dữ liệu: Vnexpress/Infographics") +
    scale_color_manual(name = NULL, values = c("#9c954d", "#b067a3"))


# GII Index ---------------------------------------------------------------

gii_index <- readr::read_csv("visualization_ggplot2/gii-index.csv")

gii_index <- gii_index %>%
    mutate(criteria = forcats::fct_reorder(criteria, score))

ggplot(gii_index, aes(factor(criteria), score,
                      color = factor(year))) +
    geom_point(size = 2) +
    labs(x = NULL, y =NULL,
         title = "Chỉ số đổi mới sáng tạo toàn cầu",
         subtitle = "Kết quả 2018 và mục tiêu 2020") +
    scale_color_manual(name = NULL,
                       values = c("#b067a3",
                                 "#9c954d")) +
    coord_flip()



# PCI ranking -------------------------------------------------------------

pci <- data.frame(
    year = 2011:2015,
    hanoi = c(36, 51, 33, 26, 24),
    haiphong = c(45, 50, 15, 34, 28),
    danang = c(5, 12, 1, 1, 1),
    saigon = c(20, 13, 10, 4, 6),
    cantho = c(16, 14, 6, 15, 14)
)

pci <- pci %>%
    gather(city, rank, -year) %>%
    mutate(city = case_when(
        city == "cantho" ~ "Cần Thơ",
        city == "danang" ~ "Đà Nẵng",
        city == "haiphong" ~ "Hải Phòng",
        city == "hanoi" ~ "Hà Nội",
        city == "saigon" ~ "Sài Gòn",
    ))

ggplot(pci, aes(year, rank, color = city)) +
    geom_point() +
    geom_line() +
    labs(x = NULL, y = NULL,
         title = "Thứ hạng PCI của 5 thành phố trực thuộc TW",
         caption = "Nguồn: VCCI") +
    scale_y_reverse() +
    scale_color_viridis_d(name = NULL)


# Apartment Price -------------------------------------------------------

apart_price <- data.frame(
    district = c("Hà Đông", "Long Biên", "Ba Đình", "Cầu Giấy", "Đống Đa", "Tây Hồ", "Bắc Từ Liêm",
             "Nam Từ Liêm", "Hoàng Mai", "Thanh Xuân"),
    q012016 = c(78.94, 85.18, 84.45, 79.22, 79.23, 87.25, 73.69, 74.47, 75.27, 80.72),
    q042015 = c(78, 84, 86, 79, 80, 87, 73, 74, 74, 82),
    stringsAsFactors = FALSE
)

apart_price <- apart_price %>%
    mutate(q012016 = q012016 - 100,
           q042015 = q042015 - 100) %>%
    mutate(district = forcats::fct_reorder(district, q012016))

apart_price <- apart_price %>%
    gather(year, rate, -district) %>%
    mutate(year = case_when(
        year == "q012016" ~ "Q01/2016",
        year == "q042015" ~ "Q04/2015",
    ))

ggplot(apart_price, aes(district, rate)) +
    geom_point(aes(fill = year, alpha = year), shape = 21, size = 5, color = "white") +
    scale_fill_manual(name = NULL, values = c("red4", "gray80")) +
    scale_alpha_manual(values = c(1, 0.8), guide = FALSE) +
    scale_y_continuous(limits = c(-28, 0),
                       labels = scales::percent_format(scale = 1)) +
    labs(x = NULL, y = NULL,
         title = "Gía nhà chung cư Hà Nội giảm mạnh sau 5 năm",
         subtitle = "Thời điểm gốc: Quý 1/2011") +
    theme_minimal() +
    theme(panel.grid.major.x = element_blank())


# Top Car Sales -----------------------------------------------------------

car_sales <- readr::read_csv("visualization_ggplot2/top_sales.csv")

car_sales <- car_sales %>%
    group_by(auto) %>%
    mutate(total_sales = sum(sales)) %>%
    ungroup() %>%
    mutate(auto = forcats::fct_reorder(auto, total_sales))

pall <- ggplot(car_sales, aes(auto, sales, fill = region)) +
    geom_col(show.legend = FALSE) +
    labs(x = NULL, y = NULL,
         title = "10 ôtô bán chạy nhất Việt Nam 02/2017") +
    scale_fill_manual(values = c("#cb6751",
                                 "#7aa457",
                                 "#9e6ebd")) +
    coord_flip() +
    theme_minimal() +
    theme(panel.grid.major.y = element_blank())
pall


south <- ggplot(filter(car_sales, region == "South")) +
    geom_col(aes(forcats::fct_reorder(auto, sales), sales),
             fill = "#9e6ebd") +
    labs(x = NULL, y = NULL, title = "Miền Nam") +
    coord_flip() +
    theme_minimal() +
    theme(panel.grid.major.y = element_blank())
south

central <- ggplot(filter(car_sales, region == "Central")) +
    geom_col(aes(forcats::fct_reorder(auto, sales), sales),
             fill = "#cb6751") +
    labs(x = NULL, y = NULL, title = "Miền Trung") +
    coord_flip() +
    theme_minimal() +
    theme(panel.grid.major.y = element_blank())
central

north <- ggplot(filter(car_sales, region == "North")) +
    geom_col(aes(forcats::fct_reorder(auto, sales), sales),
             fill = "#7aa457") +
    labs(x = NULL, y = NULL, title = "Miền Bắc") +
    coord_flip() +
    theme_minimal() +
    theme(panel.grid.major.y = element_blank())
north

(south | north | central) / pall
