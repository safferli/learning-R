# library(datasets)
# library(data.table)
# data(iris)
# ?iris
# df <- data.frame(iris)
# dt <- data.table(df)
# meanSepal <- mean(subset(dt, Species == "virginica")$Sepal.Length)
# 
# data(mtcars)
# cars <- data.table(mtcars)
# 
# 
# mpg <- tapply(mtcars$mpg, mtcars$cyl, mean)
# mpg[1]-mpg[3]
# hp <- tapply(mtcars$hp, mtcars$cyl, mean)
# abs(hp[1]-hp[3])

set.seed(1)
rpois(5, 2)

set.seed(10)
x <- rbinom(10, 10, 0.5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
