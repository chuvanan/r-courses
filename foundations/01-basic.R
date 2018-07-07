



## -----------------------------------------------------------------------------
## Arithmetic with R


12 + 22    # addition

22 - 10    # subtraction

3 * 3    # multiplication

15 / 5    # division

2 ^ 3    # exponentiation

5 %% 2    # modulus

5 %/% 2    # integer division


## Your turn ------------------------------

## Type 2^5 in the editor to calculate 2 to the power 5.


## Type 28 %% 6 to calculate 28 modulo 6.


## -----------------------------------------------------------------------------
## Comments

## Note how the symbol '#' is used to add comment on the R code

## print("this is the first comment line")
print("this is the second comment line")


## -----------------------------------------------------------------------------
## Variable Assignment

## A basic concept in (statistical) programming is called a 'variable'.

## A variable allows you to store a value (e.g. 4) in R

## Examples:
celsius <- 24
fahrenheit <- (celsius * 9 / 5) + 32
print(fahrenheit)


## Your turn ------------------------------

## Assign the value 42 to x


## Print out the value of the variable x


## Assign the value 5 to the variable 'my_apples'


## Print out the value of the variable 'my_apples'


## Assign to 'my_oranges' the value 6.


## Add the variables 'my_apples' and 'my_oranges' and have R simply print the
## result.


## Assign the result of adding 'my_apples' and 'my_oranges' to a new variable
## 'my_fruit'.



## -----------------------------------------------------------------------------
## Functions


## Built-in functions

abs(-145)    # absolute value

sqrt(9)    # square root

sum(c(1, 3, 5, 7, 9))    # sum of all values

lm(dist ~ speed, data = cars)    # fit linear models

plot(cars$speed, cars$dist)    # generate X-Y plot

## User-written functions

say_hello <- function(to) {
    paste0("Hello ", to, ". Nice to meet you!")
}

say_hello(to = "An Chu")


## Your turn ------------------------------

## Write your own function to convert Fahrenheit to Celsius degree.

to_celcius <- function(x) {
    ## your code goes here

}

## Expected output:
## to_celcius(x = 50)
## R> [1] "50 Fahrenheit is equal to 10 Celcius"


## -----------------------------------------------------------------------------
## Packages


## syntax:

## install.packages(pkgs = "name_of_package(s)")

install.packages("dplyr")
install.packages(c("tidyr", "ggplot2"))

## update packages
update.packages()

## Load package into R workspace
library(dplyr)

## Your turn ------------------------------

## Make sure you have the following packages installed on your laptop

## readr, tidyr, dplyr, stringr, ggplot2, knitr, rmarkdown

## -----------------------------------------------------------------------------
## R packages growth

library(ggplot2)
date <- c( "2017-12-15", "2017-07-04", "2017-01-27", "2016-08-22", "2016-02-29",
          "2015-08-12", "2014-10-29", "2013-11-08", "2012-08-23", "2011-05-12",
          "2009-10-04", "2007-04-12", "2004-10-01", "2003-04-01", "2002-09-17",
          "1997-04-23")
n <- c( 12000, 11000, 10000, 9000, 8000, 7000, 6000, 5000, 4000, 3000, 2000,
       1000, 500, 250, 68, 12 )
r_pkgs <- data.frame(date, n, stringsAsFactors = FALSE)
r_pkgs$date <- as.Date(r_pkgs$date)
ggplot(r_pkgs, aes(date, n)) +
    geom_line() +
    geom_point() +
    labs(x = NULL, y = "Number of packages", title = "CRAN's package growth")
