install.packages("ggplot2")
install.packages("ggmap")
install.packages("GGally")

zlibrary(ggplot2)
library(ggmap)
library(GGally)

# Using IRIS Dataset

ir<-iris

str(iris)

plot(x = ir$Petal.Width, y = ir$Petal.Length, 
     main = "Petal Width Vs. Length", 
     xlab = "Petal Width", ylab = "Petal Length", 
     col = ir$Species, 
     pch = as.numeric(ir$Species), 
     lwd=2)

cor(x = ir$Petal.Width, y = ir$Petal.Length)

plot(x = ir$Sepal.Width, y = ir$Sepal.Length,
    main = "Sepal Width Vs. Length", 
    xlab = "Sepal Width", ylab = "Sepal Length", 
    col = ir$Species, 
    pch = as.numeric(ir$Species), 
    lwd=2)

cor(x = ir$Sepal.Width, y = ir$Sepal.Length)


ggcorr(iris, label = TRUE)


# Boxplots

plot(ir$Species,ir$Sepal.Width, col = "blue", main = "BoxPlot of Species Vs. SWidth")

# Histogram

hist(ir$Sepal.Width, col = "Orange")

# Multiple Plots

par(mfrow=c(1,2))
dev.off()

data(iris)
par(mfrow=c(2,2))
boxplot(iris$Sepal.Length,col="red")
boxplot(iris$Sepal.Length~iris$Species,col="red")
boxplot(iris$Sepal.Length~iris$Species,col=heat.colors(3))
boxplot(iris$Sepal.Length~iris$Species,col=topo.colors(3))
dev.off()


