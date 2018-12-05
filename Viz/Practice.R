# Import GGPLOT2

setwd("/Users/Sam/dev/r/Viz")

library(ggplot2)

data()
data("iris")
head(iris)
dim(iris)
summary(iris)

plot(iris)

ggplot(iris, aes(x = Petal.Length, y = Sepal.Width)) +
  geom_point()

install.packages("openxlsx", dependencies = TRUE)
library(openxlsx)
