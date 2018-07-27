## An analysis of Diem thi THPT 2018


library(dplyr)
library(ggplot2)
library(patchwork)
read_csv <- readr::read_csv
str_sub <- stringr::str_sub

## Import data -------------------------------------------------------------


setwd("~/Documents/r-courses/")
diemthi <- read_csv("./data/THPT 2018 Quoc gia.csv")
diemthi$X12 <- NULL
prov_code <- read_csv("./data/prov-code.csv")

## Clean data --------------------------------------------------------------

## Guess province id from SoBD

diemthi <- mutate(diemthi,
                  SoBD = case_when(
                      nchar(SoBD) == 7L ~ paste0("0", SoBD),
                      TRUE ~ as.character(SoBD))
                  )

diemthi <- diemthi %>% mutate(ProvID = str_sub(SoBD, 1, 2))
diemthi <- left_join(diemthi, prov_code)

test <- diemthi %>%
    group_by(ProvID, ProvLabel) %>%
    summarise(med_math = median(Math, na.rm = TRUE)) %>%
    ungroup()

diemthi %>%
    group_by(ProvID, ProvLabel) %>%
    summarise(mea_math = mean(Math, na.rm = TRUE)) %>%
    ungroup()

ggplot(test, aes(med_math)) +
    geom_dotplot() +
    geom_dotplot(data = filter(test, ProvID == "05"), aes(med_math), fill = "red4")

## EDA ---------------------------------------------------------------------

math_plot <- ggplot(diemthi, aes(Math, group = ProvID)) +
    geom_line(color = "white", stat = "density") +
    geom_line(data = filter(diemthi, ProvID == "05"),
              color = "orange", stat = "density", size = 0.8) +
    annotate("text", 2, 0.3, label = "Hà Giang", size = 4, hjust = 0.9, color = "red4") +
    scale_x_continuous(breaks = seq(0, 10, 2), name = NULL) +
    scale_y_continuous(labels = NULL, name = NULL) +
    labs(title = "Math") +
    theme_minimal(base_size = 14, base_family = "Roboto Slab") +
    theme(axis.ticks = element_blank(),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "gray50"))

ggplot_helper <- function(dta, subj, title = subj) {
    ggplot(data = dta, aes_string(subj, group = "ProvID")) +
        geom_line(color = "gray80", stat = "density") +
        geom_line(data = filter(dta, ProvID == "05"),
                  color = "red4", stat = "density", size = 0.8) +
        scale_x_continuous(breaks = seq(0, 10, 2), name = NULL) +
        scale_y_continuous(labels = NULL, name = NULL) +
        labs(title = title) +
        theme_minimal(base_size = 14, base_family = "Roboto Slab") +
        theme(axis.ticks = element_blank(),
              panel.grid.minor.y = element_blank())
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
