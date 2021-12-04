# Meri Korhonen 4.12.2021
# Version 2 of create_human.R
# Read data, modify and combine the two datasets, save the result

# read the data and check the structure
human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", stringsAsFactors = F)
str(human)

# access the stringr package
library(stringr)

# remove the commas from GNI and replace it with numeric version
human$GNI <- str_replace(human$GNI, pattern=",", replace ="")
human$GNI <- as.numeric(human$GNI)
is.numeric(human$GNI)

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# access the dplyr library
library(dplyr)

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

# look at the last 10 observations of human
tail(human_, n = 10)

# define the last indice we want to keep (= exclude larger regions)
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

# remove the Country variable
human_ <- select(human_, -Country)

# check the data, should include 155 obs and 8 var
str(human_)

# overwrite the original human data set with the new one
human <- human_

# write the new data set
write.csv(human, file = "data/human.csv")

# read the data set and check the structure
data = read.csv("data/human.csv")
str(data)
