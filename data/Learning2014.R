# Eric Coles
# Nov 14, 2017
# Data wrangling

# read the dataset
lrning2014 <-read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#explore the structure
str(lrning2014)

# explore the dimension of the data
dim(lrning2014)

#data.frame has 183 obs. of  60 variables. Contains both integers and factors.

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns<-select(lrning2014, one_of(deep_questions))
lrning2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrning2014, one_of(surface_questions))
lrning2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrning2014, one_of(strategic_questions))
lrning2014$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrning2014, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# learning2014 is available

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# print out the new column names of the data

colnames(learning2014)

# learning2014 is available

# access the dplyr library
library(dplyr)

# select male students
male_students <- filter(learning2014, gender == "M")

# select rows where Points is greater than zero
learning2014 <- filter(learning2014, points > 0)


# set the working directory to data folder in IODS-project
# setwd("~/Documents/GitHub/IODS-project/data")

write.csv(learning2014, file = "learning2014.csv", row.names = FALSE) 
# read the data and check for the validity
learning2014<- read.csv(file="learning2014.csv")



# check the dataset
str(learning2014)
head(learning2014)

