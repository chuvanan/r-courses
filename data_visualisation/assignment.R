# An analysis of Diem thi THPT 2018


library(dplyr)
library(rvest)
library(ggplot2)
library(patchwork)
read_csv <- readr::read_csv
str_sub <- stringr::str_sub

# Import data -------------------------------------------------------------


setwd("~/Documents/r-courses/")
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

math_plot <- ggplot(diemthi, aes(Math, group = ProvID)) +
    geom_line(color = "gray80", stat = "density") +
    geom_line(data = filter(diemthi, ProvID == "05"),
              color = "red4", stat = "density", size = 0.7) +
    annotate("text", 2, 0.3, label = "Hà Giang", size = 4, hjust = 0.9, color = "red4") +
    scale_x_continuous(expand = c(0, 0), breaks = 0:10, name = NULL) +
    scale_y_continuous(expand = c(0, 0), labels = NULL, name = NULL) +
    labs(title = "Math") +
    theme_minimal(base_size = 14, base_family = "Roboto Slab") +
    theme(axis.ticks = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid = element_line(color = "white"),
          plot.background = element_rect(fill = "gray98", color = "gray98"))

ggplot_helper <- function(dta, subj, title = subj) {
    ggplot(data = dta, aes_string(subj, group = "ProvID")) +
        geom_line(color = "gray80", stat = "density") +
        geom_line(data = filter(dta, ProvID == "05"),
                  color = "red4", stat = "density", size = 0.7) +
        scale_x_continuous(expand = c(0, 0), breaks = 0:10, name = NULL) +
        scale_y_continuous(expand = c(0, 0), labels = NULL, name = NULL) +
        labs(title = title) +
        theme_minimal(base_size = 14, base_family = "Roboto Slab") +
        theme(axis.ticks = element_blank(),
              panel.grid.minor.y = element_blank(),
              panel.grid.minor.x = element_blank(),
              panel.grid = element_line(color = "white"),
              plot.background = element_rect(fill = "gray98", color = "gray98"))
}

viet_plot <- ggplot_helper(diemthi, subj = "Viet")
english_plot <- ggplot_helper(diemthi, subj = "English")
physics_plot <- ggplot_helper(diemthi, subj = "Physics")
chemistry_plot <- ggplot_helper(diemthi, subj = "Chemistry")
biology_plot <- ggplot_helper(diemthi, subj = "Biology")
geography_plot <- ggplot_helper(diemthi, subj = "Geography")
gdcd_plot <- ggplot_helper(diemthi, subj = "GDCD")


math_plot + viet_plot + english_plot + physics_plot +
    chemistry_plot + biology_plot + geography_plot + gdcd_plot +
    plot_layout(nrow = 2)
