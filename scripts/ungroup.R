


#' ### Suppose that we have a simple data frame as follows:

#+ message=FALSE
library(dplyr)

dta <- data_frame(
    grp = c("A", "B", "B", "A", "A"),
    val = c(1, 6, 3, 4, 8)
)

#+ echo=FALSE
print(dta)

#' ### Let's use group_by() to aggregate data by variable `grp`

#' Notice that `grouped` is still grouped by `grp` (see the second row in output)
grouped <- dta %>%
    group_by(grp) %>%
    mutate(max_val = max(val))

#+ echo=FALSE
print(grouped)


#' `ungrouped` has no internal groupings
ungrouped <- dta %>%
    group_by(grp) %>%
    mutate(max_val = max(val)) %>%
    ungroup()

#+ echo=FALSE
print(ungrouped)


#' ### Here's the effect of ungroup() when we try to create new variable

grouped %>%
    mutate(sum_val = sum(val))

ungrouped %>%
    mutate(sum_val = sum(val))
