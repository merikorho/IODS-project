# Meri Korhonen 9.11.2021
# Exercise 2: linear regression and model validation

# read the data as a dataframe
lrn14 = read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", as.is = TRUE, header = TRUE, sep = "\t") 

# look at the dimensions of the data
dim(lrn14)

# look at the structure of the data
str(lrn14)

# Access the dplyr library
library(dplyr)

# scale attitude to the scale 0...5 and save to a new column
lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose the columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

# see the stucture of the new dataset (should be 166 obs. and 7 variables)
str(learning2014)

# write the new data set
write.csv(learning2014, file = "data/learning2014.csv")

# read the data set and check the structure
data = read.csv("data/learning2014.csv")
str(data)
