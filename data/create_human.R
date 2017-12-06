
#Created on 30.11.2017
#Eric Coles
#RStudio exercise 5 -- Data wrangling
#Data source, United Nations Development Programme. 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# Modify the column names of data
colnames(hd) <- c("hdir", "cnty", "hdi", "life", "edu", "edu.mean", "gni", "gni")
colnames(gii) <- c("giirnk", "cty", "gii", "mort.M", "t.birth", "Par.M", "edu2F", "edu2M", "labF", "labM")

# Modify the column names of Human Development dataset and Gender inequality data
column_names_hd=c('HDI.Rank','Country','HDI','Life.Exp','Edu.Exp','Edu.Mean','GNI','GNI.Minus.Rank')
colnames(hd)=column_names_hd
column_names_gii=c('GII.Rank','Country','GII','Mat.Mor','Ado.Birth','Parli.F','Edu2.F','Edu2.M','Labo.F','Labo.M')
colnames(gii)=column_names_gii

# Calculate the ratio of female and male populations with secondary education and labour force participation in each country
gii=mutate(gii,Edu2.FM=Edu2.F/Edu2.M,Labo.FM=Labo.F/Labo.M)

# Join the two datasets
human=inner_join(hd,gii,by='Country')
dim(human)
summary(human)
# Mutate the GNI data in 'human' dataset
str(human$GNI)
human$GNI=str_replace(human$GNI,pattern=',',replace='') %>% as.numeric

# Dealing with not available (NA) values
keep=c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human=select(human,one_of(keep))
human=filter(human,complete.cases(human))

# Remove observations with related to regions instead of countries
last=nrow(human)-7
human_=human[1:last,]

# Define the row names of the data by the country names
rownames(human_)=human_$Country
human=human_[-1]

# Save data
setwd('/Users/eric/Documents/GitHub/IODS-project/data')
write.table(human,file='human.txt',row.names=T,sep = '\t')

str(human)

