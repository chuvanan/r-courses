

##' ## To quantile or not to quantile

##' Ref: http://rpubs.com/minhthu/404294

library(readr)
library(dplyr)
library(ggplot2)
library(patchwork)


##+ message=FALSE
sales <- read_csv("sales_canceled.csv")

##' ### Count the number of cancellation per item
cancelled <- sales %>%
    filter(Status == "Canceled") %>%
    group_by(Item.Code) %>%
    summarise(n_cancelled = sum(Quantity)) %>%
    arrange(desc(n_cancelled))


##+ include=FALSE
cancelled <- mutate(cancelled, id = 1:nrow(cancelled))

##+ echo=FALSE
print(cancelled)

##' Calculate 80% of the cancelled
threshold <- round(sum(cancelled$n_cancelled) * 0.8, 0)

##+ echo=FALSE
print(threshold)

##' Calculate the 20% quantile of the cancelled
quantile20 <- round(quantile(cancelled2$n_cancelled, 0.2), 0)

##+ echo=FALSE
print(quantile20)


##' ### Solution 1

##' **Idea: Keep items that account for 80% of all cancelled orders**

##+ echo=FALSE, fig.width=9, fig.height=7, dpi=300
p1 <- ggplot(cancelled, aes(id, n_cancelled)) +
    geom_point() +
    geom_vline(xintercept = 24, linetype = "dashed") +
    labs(x = NULL, y = NULL,
         title = "Number of cancelled ordres per item, from largest (left) to smallest (right)") +
    theme_bw(base_family = "Lato") +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank())

p2 <- ggplot(cancelled, aes(id, cumsum(n_cancelled))) +
    geom_point() +
    geom_hline(yintercept = threshold, color = "red4") +
    geom_vline(xintercept = 24, linetype = "dashed") +
    annotate("text", x = 10, y = 26500, label = "80% of total cancelled", color = "red4") +
    annotate("text", x = 30, y = 15000, label = "Reaching the\n80% threshold\nat the 24th item") +
    labs(x = NULL, y = NULL, title = "Cummulative number of cancelled ordres") +
    theme_bw(base_family = "Lato") +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank())

p1 + p2 + plot_layout(ncol = 1)


##' ### Solution 2

##' **Idea: keep items that have number of cancelled orders greater than the 20%
##' quantile of all cancelled orders.**

##+ echo=FALSE, fig.width=9, fig.height=7, dpi=300
p3 <- cancelled %>%
    mutate(lt_quantile20 = n_cancelled < quantile20) %>%
    ggplot(aes(id, n_cancelled, color = lt_quantile20)) +
    geom_point() +
    scale_color_manual(values = c("black", "gray80")) +
    geom_vline(xintercept = 59, linetype = "dashed") +
    annotate("text", x = 68, y = 900,
             label = "Items that have\ncancelled orders\nless than quantile20",
             color = "gray30") +
    labs(x = NULL, y = NULL,
         title = "Number of cancelled ordres per item, from largest (left) to smallest (right)") +
    theme_bw(base_family = "Lato") +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.position = "none")

p4 <- cancelled %>%
    mutate(lt_quantile20 = n_cancelled < quantile20) %>%
    ggplot(aes(id, cumsum(n_cancelled), color = lt_quantile20)) +
    geom_point() +
    scale_color_manual(values = c("black", "gray80")) +
    geom_hline(yintercept = threshold, color = "red4") +
    geom_vline(xintercept = 59, linetype = "dashed") +
    annotate("text", x = 10, y = 26500, label = "80% of total cancelled", color = "red4") +
    annotate("text", x = 64, y = 15000, label = "Standing at\nthe 59th item") +
    labs(x = NULL, y = NULL, title = "Cummulative number of cancelled ordres") +
    theme_bw(base_family = "Lato") +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.position = "none")

p3 + p4 + plot_layout(ncol = 1)
