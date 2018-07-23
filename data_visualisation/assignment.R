# An analysis of Diem thi THPT 2018



library(dplyr)
library(rvest)
library(ggplot2)
read_csv <- readr::read_csv
str_sub <- stringr::str_sub

# Import data -------------------------------------------------------------

diemthi <- read_csv("./data/THPT 2018 Quoc gia.csv")
diemthi$X12 <- NULL

vov_link <- "http://tuyensinh.vov.edu.vn/tuyen-sinh-cao-dang-chinh-quy-2016/danh-sach-ma-tinh-ma-huyen-thi-thpt-quoc-gia-2016.htm"
prov_code <- read_html(vov_link) %>%
    html_nodes("p+ p strong") %>%
    html_text()



# Clean data --------------------------------------------------------------

# Guess province id from SoBD

diemthi <- mutate(diemthi, SoBD = case_when(
    nchar(SoBD) == 7L ~ paste0("0", SoBD),
    TRUE ~ as.character(SoBD)))

diemthi <- diemthi %>%
    mutate(ProvID = str_sub(SoBD, 1, 2))

# Get province id and label
prov_code <- data_frame(
    ProvID = str_sub(prov_code, 10, 11),
    ProvLabel = str_sub(prov_code, 15)
)

prov_code <- prov_code %>%
    mutate(ProvLabel = gsub("(THÀNH PHỐ|TỈNH)\\s", "", ProvLabel))

diemthi <- left_join(diemthi, prov_code)


# EDA ---------------------------------------------------------------------

names(diemthi)

ggplot(diemthi, aes(Math, group = ProvID)) +
    geom_density(color = "gray60", stat = "density") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "orange", stat = "density", size = 0.7) +
    annotate("text", 2, 0.3, label = "Hà Giang", size = 5, hjust = 0.9, color = "orange") +
    scale_x_continuous(expand = c(0, 0), breaks = 0:10, name = NULL) +
    scale_y_continuous(expand = c(0, 0), labels = NULL, name = NULL) +
    labs(title = "Math") +
    theme_minimal(base_size = 14, base_family = "Roboto Slab") +
    theme(axis.ticks = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_rect(fill = "#36394A", color = "#36394A"))


ggplot(diemthi, aes(Viet, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(English, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(Physics, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(Chemistry, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(Biology, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(Geography, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")

ggplot(diemthi, aes(GDCD, group = ProvID)) +
    geom_density(color = "gray80") +
    geom_density(data = filter(diemthi, ProvID == "05"),
                 color = "red4")
