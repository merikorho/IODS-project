# Meri Korhonen 28.11.2021
# Read data, modify and combine the two datasets, save the result

# read the data
human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gender <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# look at the (column) names and rename them with shorter versions
names(human)

colnames(human)[1] <- "HDIrank" # HDI rank
colnames(human)[3] <- "HDI" # Human Development Index
colnames(human)[4] <- "LEB" # Life Expectancy at Birth
colnames(human)[5] <- "EYE" # Expected Years of Education
colnames(human)[6] <- "MYE" # Mean Years of Education 
colnames(human)[7] <- "GNI" # Gross National Income
colnames(human)[8] <- "GNI-HDI" # GNI rank - HDI rank

names(gender)
colnames(gender)[1] <- "GIIrank" # GII rank
colnames(gender)[3] <- "GII" # Gender Inequality Index
colnames(gender)[4] <- "MMR" # Maternal Mortality Ratio
colnames(gender)[5] <- "ABR" # Adolescent Birth Rate
colnames(gender)[6] <- "RepPar" 
colnames(gender)[7] <- "edu2F"
colnames(gender)[8] <- "edu2M"
colnames(gender)[9] <- "labF"
colnames(gender)[10] <- "labM"

# print out summaries of the variables
summary(human)
summary(gender)

# ratio of female and male populations with secondary education
gender$eduR <- gender$edu2F/gender$edu2M

# ratio of labor force participation of females and males
gender$labR <- gender$labF/gender$labM

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("Country")

# join the two datasets by the selected identifiers
human_new <- inner_join(human, gender, by = join_by)
colnames(human_new)
str(human_new) # 195 obs, 19 variables

# overwrite the original human data set with the new one
human <- human_new

# write the new data set
write.csv(human, file = "data/human.csv")

# read the data set and check the structure
data = read.csv("data/human.csv")
str(data)
