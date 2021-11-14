# Meri Korhonen 9.11.2021
# Script to fit linear regression model

# read the data set and check the structure
df = read.csv("data/learning2014.csv")
str(df)

# access the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# create a summary plot matrix of all variables with ggpairs()
#ggpairs(df[-1], lower = list(combo = wrap("facethist", bins = 20)))
# create a more advanced plot matrix with ggpairs()
ggpairs(df[-1], mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))

# --- PLOT SCATTER PLOTS WITH LINEAR REGRESSION (plots not included in the final analysis)

# initialize plot with data and aesthetic mapping
p1 <- ggplot(df, aes(x = stra, y = Points, col = gender))
# define the visualization type (points)
p2 <- p1 + geom_point()
# add a regression line
p3 <- p2 + geom_smooth(method = "lm")
# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's strategic approach versus exam points")
# draw the plot
p4

# another scatter plot (no gender distinction) of points versus attitude
qplot(attitude, Points, data = df) + geom_smooth(method = "lm")

# --- FIT LINEAR MODEL

# create a regression model with multiple explanatory variables
my_model <- lm(Points ~ attitude + stra + surf, data = df)
# print out a summary of the model
summary(my_model)

# see the results of the model with only attitude as explanatory variable
my_model2 <- lm(Points ~ attitude, data = df)
summary(my_model2)


# draw diagnostic plots using the plot() function. Choose the plots 1, 2 and 5
par(mfrow = c(2,2))
plot(my_model2, which = c(1,2,5))
