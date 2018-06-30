# Data structures in R
# 12/2017


# Why?
mean
sum
lm

# atomic vectors ----------------------------------------------------------

x <- c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE)

y <- c(1L, 2L, 5L, 4L, 3L)

z <- c(1.23, 3.21, 2.35, 2.4, 2.13, 4.56)

w <- c("a", "b", "c", "d", "e", "f", "g", "h")


typeof(x)
length(x)

typeof(y)
length(x)

typeof(z)
length(x)

typeof(w)
length(x)


# create named atomic vector
names(z) <- c("a", "b", "c", "d", "e", "f")
names(z)


# checking ----------------------------------------------------------------

is.double(x)
is.double(y)
is.double(z)

# numeric is identical to double
is.numeric(z)
is.double(z)

# different use case
is.numeric(y)
is.double(y)
is.integer(y)


# conversion --------------------------------------------------------------

y
as.logical(y)

z
as.integer(z)

x
as.double(x)

x
as.character(x)


# automatic conversion ----------------------------------------------------


sum(c(TRUE, FALSE, TRUE))
c(TRUE, FALSE, TRUE, TRUE, "FALSE")
c(1, 2, 3, 4, FALSE)
c(10L, 11L, 12)



# matrix ------------------------------------------------------------------


# create matrix by combinning atomic vectors (of same length)
mat <- cbind(c(1L, 2L, 3L, 4L, 5L),
             c(6L, 7L, 8L, 9L, 10L),
             c(11L, 12L, 13L, 14L, 15L))

mat <- rbind(c(1L, 6L, 11L),
             c(2L, 7L, 12L),
             c(3L, 8L, 13L),
             c(4L, 9L, 14L),
             c(5L, 10L, 15L))


# R create matrix column-wise
mat <- matrix(1L:15L, ncol = 3)

# set byrow = TRUE to have row-wise matrix
mat_rowwise <- matrix(1L:15L, ncol = 3, byrow = TRUE)


# properties
typeof(mat) # storage mode
class(mat) # object class


dim(mat)
nrow(mat)
ncol(mat)

# matrix with dimnames attribute
mat <- matrix(1L:15L, ncol = 3)
dimnames(mat) <- list(c("R1", "R2", "R3", "R4", "R5"),
                    c("A", "B", "C"))

mat
dimnames(mat)
rownames(mat)
colnames(mat)

# append matrix
rbind(mat, mat)
cbind(mat, mat)


# array -------------------------------------------------------------------

arr <- array(1L:45L, dim = c(5, 3, 3))

typeof(arr)

class(arr)

dim(arr)


# list --------------------------------------------------------------------


my_list <- list(c(1L, 2L, 3L),
                text = c("a", "b"),
                boolean = c(TRUE, FALSE, FALSE, TRUE))
str(my_list)


# combine list (flat)
your_list <- list(num = c(12.34, 34.45, 45.56))
new_list <- c(my_list, your_list)
str(new_list)


# application of list
reg_lm <- lm(dist ~ speed, data = cars)
is.list(reg_lm)

names(reg_lm)
length(reg_lm)


# data frame --------------------------------------------------------------


# create data frame from vector
dtf <- data.frame(x = c("a", "b", "c", "d", "e", "f", "g", "h"),
                  z = c(1.23, 3.21, 2.35, 2.4, 2.13, 4.56, 2.13, 4.56),
                  w = c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE),
                  y = c(1L, 2L, 5L, 4L, 3L, 4L, 3L, 4L),
                  stringsAsFactors = FALSE)
str(dtf)

# from matrix
mat_df <- as.data.frame(mat)
str(mat_df)

# from list: not really
as.data.frame(my_list)


# factors -----------------------------------------------------------------


month_chr <- c("Jan", "Dec", "Apr", "November", "May")

month_fac <- factor(month_chr,
                    levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                               "Aug", "Sep", "Oct", "Nov", "Dec"))
month_fac

typeof(month_chr)

typeof(month_fac)

class(month_fac)
levels(month_fac)
unclass(month_fac)

sum(month_fac) # did not work

sort(month_chr)
sort(month_fac)

table(month_chr)
table(month_fac) # count elements of each group even has no observations

# make groups from continuous variables
cont_var <- rnorm(100)

cont_grp <- cut(cont_var, breaks = 8)

table(cont_grp)


# dates & times -----------------------------------------------------------

now <- Sys.time()
class(now)
typeof(now)
unclass(now)

now_lt <- as.POSIXlt(now)
typeof(now_lt)
unclass(now_lt)

today <- Sys.Date()
class(today)
typeof(today)
unclass(today)

# parsing dates and times -------------------------------------------------


date1 <- "6aug2005"
as.Date(date1, format = "%d%B%Y")

date2 <- "aug061999"
as.Date(date2, format = "%B%d%Y")

date3 <- "12-05-2001"
as.Date(date3, format = "%m-%d-%Y")

date4 <- "May 27 1984"
as.Date(date4, format = "%B %d %Y")

date5 <- "1998-22-07"
as.Date(date5, format = "%Y-%d-%m")

date6 <- "20041024"
as.Date(date6, format = "%Y%m%d")

date7 <- "22.10.2004"
as.Date(date7, format = "%d.%m.%Y")


num_vect <- c(1, 2, 3, 4, 5)
lgl_vect <- c(TRUE, FALSE, TRUE, FALSE)
chr_vect <- c("a", "b", "c", "d", "e")
dat_vect <- as.Date(c("2017-12-02", "2017-12-16", "2017-12-28"))


mean(num_vect)

mean(lgl_vect)

mean(chr_vect)

mean(dat_vect)

