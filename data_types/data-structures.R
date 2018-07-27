


library(forcats)



str(gss_cat$race)
levels(gss_cat$race)

count(gss_cat, race)

with(gss_cat, table(race))


ggplot(gss_cat, aes(race)) +
    geom_bar() +
    scale_x_discrete(drop = FALSE)


gss_cat %>%
    group_by(race) %>%
    summarise(n = n())
