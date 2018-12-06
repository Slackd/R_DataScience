install.packages("ggplot2")
install.packages("ggmap")
install.packages("GGally")

library(ggplot2)
library(ggmap)
library(GGally)

# Using IRIS Dataset ----

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


# Boxplots ----

plot(ir$Species,ir$Sepal.Width, col = "blue", main = "BoxPlot of Species Vs. SWidth")

# Histogram ----

hist(ir$Sepal.Width, col = "Orange")

# Multiple Plots ----

par(mfrow=c(1,2))
dev.off()

data(iris)
par(mfrow=c(2,2))
boxplot(iris$Sepal.Length,col="red")
boxplot(iris$Sepal.Length~iris$Species,col="red")
boxplot(iris$Sepal.Length~iris$Species,col=heat.colors(3))
boxplot(iris$Sepal.Length~iris$Species,col=topo.colors(3))
dev.off()


# GGPLOT 2 ----

install.packages("sp")

library(sp)
        
data("meuse")
head(meuse)

meuse<-meuse[5,]

data("Orange")
library(ggplot2)
or<-Orange
p<-ggplot(or,aes(x=age,y=circumference, col=Tree))
p+geom_point()

str(Orange)




K<-seq(2,20,by=2); for(I in K){ print(I)}
i<-1:5; print(2*i-1)
K<-1:10; for(I in K){ print(2*I-1)}
K<-seq(2,20,by=2); for(I in K){ print(I)}

strDates <-"01/20/2014"
as.Date(strDates, "%Y/%d/%m")

abline(h=5)


data(iris)
hist(iris$Sepal.Length, density = TRUE)
hist(iris$Sepal.Length,freq=TRUE)


D<-data.frame(CSK,DDD,MI)
D<-list(CSK,DDD,MI)

x<-c(10,50,NA,NA,100)
Mean_x <- mean(na.omit (x))
Mean_x

y<-c(500,1500,NA,NA,2500)
Mean_x <- mean(na.omit (y))
Mean_x



