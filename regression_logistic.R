# Meri Korhonen 20.11.2021
# Script to fit logistic regression model

# read the data set and check the structure
alc = read.csv("data/alcohol_use.csv")
str(alc)

# access the tidyverse libraries tidyr, dplyr, ggplot2
library(tidyr); library(dplyr); library(ggplot2)


# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# initialize a plot of 'high_use'
#g2 <- ggplot(data = alc, aes(x = high_use, fill = sex))

# draw a bar plot of high_use by sex
#g2 + geom_bar() + facet_wrap("sex")

# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
#gather(alc) %>% glimpse

# draw a bar plot of each variable
gather(alc[-1]) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()

# produce summary statistics by group
alc %>% group_by(sex, high_use) %>% summarise(count = n(), mean_grade = mean(G3))

# initialize a plot of high_use and G3
g1 <- ggplot(alc, aes(x = high_use, y = G3, col = sex))

# define the plot as a boxplot and draw it
g1 + geom_boxplot() + ylab("grade")

# initialise a plot of high_use and absences
g2 <- ggplot(alc, aes(x = high_use, y = absences, col = sex)) 

# define the plot as a boxplot and draw it
g2 + geom_boxplot() + ylab("absences") + ggtitle("Student absences by alcohol consumption and sex")

# initialise a plot of high_use and going out
g3 <- ggplot(alc, aes(x = high_use, y = goout, col = sex))

# define the plot as a boxplot and draw it
g3 + geom_boxplot() + ylab("going out") + ggtitle("Going out by alcohol consumption and sex")

# initialise a plot of high_use and absences
g4 <- ggplot(alc, aes(x = high_use, y = famrel, col = sex))

# define the plot as a boxplot and draw it
g4 + geom_boxplot() + ylab("family relations") + ggtitle("Student family relations by alcohol consumption and sex")


### --- LOGISTIC REGRESSION

# find the model with glm()
m <- glm(high_use ~ absences + G3 + failures + famrel, data = alc, family = "binomial")

# print out a summary of the model
summary(m)

# find the model with glm()
m2 <- glm(high_use ~ absences + failures, data = alc, family = "binomial")

# print out a summary of the model
summary(m2)

# print out the coefficients of the model
#coef(m)

# compute odds ratios (OR)
OR <- coef(m) %>% exp

# compute confidence intervals (CI)
CI <- confint(m) %>% exp

# print out the odds ratios with their confidence intervals
cbind(OR, CI)

# predict() the probability of high_use
probabilities <- predict(m2, type = "response")

# add the predicted probabilities to 'alc'
alc <- mutate(alc, probability = probabilities)

# use the probabilities to make a prediction of high_use
alc <- mutate(alc, prediction = probability > 0.5)

# see the last ten original classes, predicted probabilities, and class predictions
select(alc, failures, absences, high_use, probability, prediction) %>% tail(10)

# tabulate the target variable versus the predictions
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table() %>% addmargins()
#table(high_use = alc$high_use, prediction = alc$prediction)


# initialize a plot of 'high_use' versus 'probability' in 'alc'
g <- ggplot(alc, aes(x = probability, y = high_use, col = prediction))

# define the geom as points and draw the plot
g + geom_point()

###

# define a loss function (mean prediction error)
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

# compute the average number of wrong predictions in the (training) data
loss_func(class = alc$high_use, prob = alc$probability)


# K-fold cross-validation
library(boot)
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m, K = 10)

# average number of wrong predictions in the cross validation
cv$delta[1]
