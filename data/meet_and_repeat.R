# 12.12.2021 Meri Korhonen
# Week 6 data-wrangling of two datasets

library(tidyr); library(dplyr)

# ------ PART I ------ #

# Read BPRS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Check the structure and summary
names(BPRS)
str(BPRS)
summary(BPRS)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

names(BPRSL)
str(BPRSL)
summary(BPRSL)
glimpse(BPRSL)

# Write the data
write.csv(BPRSL, file = "data/BPRSL.csv")

# ------ PART II ------ #

# read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Glimpse the data
glimpse(RATS)

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)

# Write the data
write.csv(RATSL, file = "data/RATSL.csv")
