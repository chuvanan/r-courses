Suppose that we have a simple data frame as follows:


```r
library(dplyr)

dta <- data_frame(
    grp = c("A", "B", "B", "A", "A"),
    val = c(1, 4, 3, 6, 8)
)
```

```
## # A tibble: 5 x 2
##   grp     val
##   <chr> <dbl>
## 1 A         1
## 2 B         4
## 3 B         3
## 4 A         6
## 5 A         8
```

Notice


```r
grouped <- dta %>%
    group_by(grp) %>%
    mutate(max_val = max(val))
```

In this case, `ungrouped` has no internal groupings


```r
ungrouped <- dta %>%
    group_by(grp) %>%
    mutate(max_val = max(val)) %>%
    ungroup()
```




```r
grouped %>%
    mutate(sum_val = sum(val))
```

```
## # A tibble: 5 x 4
## # Groups:   grp [2]
##   grp     val max_val sum_val
##   <chr> <dbl>   <dbl>   <dbl>
## 1 A         1       8      15
## 2 B         4       4       7
## 3 B         3       4       7
## 4 A         6       8      15
## 5 A         8       8      15
```




```r
ungrouped %>%
    mutate(sum_val = sum(val))
```

```
## # A tibble: 5 x 4
##   grp     val max_val sum_val
##   <chr> <dbl>   <dbl>   <dbl>
## 1 A         1       8      22
## 2 B         4       4      22
## 3 B         3       4      22
## 4 A         6       8      22
## 5 A         8       8      22
```

