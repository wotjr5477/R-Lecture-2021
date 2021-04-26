# 210426

# Chapter 5, 단원문제
# p. 176
library(dplyr)
# 01
NHIS2002 = read.csv('data/NHIS/NHIS_OPEN_GJ_2002_v1.CSV')
NHIS2003 = read.csv('data/NHIS/NHIS_OPEN_GJ_2003_v1.CSV')
NHIS2004 = read.csv('data/NHIS/NHIS_OPEN_GJ_2004_v1.CSV')
NHIS2005 = read.csv('data/NHIS/NHIS_OPEN_GJ_2005_v1.CSV')
NHIS2006 = read.csv('data/NHIS/NHIS_OPEN_GJ_2006_v1.CSV')
NHIS2007 = read.csv('data/NHIS/NHIS_OPEN_GJ_2007_v1.CSV')
NHIS2008 = read.csv('data/NHIS/NHIS_OPEN_GJ_2008_v1.CSV')
NHIS2009 = read.csv('data/NHIS/NHIS_OPEN_GJ_2009_v1.CSV')
NHIS2010 = read.csv('data/NHIS/NHIS_OPEN_GJ_2010_v1.CSV')
NHIS2011 = read.csv('data/NHIS/NHIS_OPEN_GJ_2011_v1.CSV')
NHIS2012 = read.csv('data/NHIS/NHIS_OPEN_GJ_2012_v1.CSV')
NHIS2013 = read.csv('data/NHIS/NHIS_OPEN_GJ_2013_v1.CSV')
NHIS2014 = read.csv('data/NHIS/NHIS_OPEN_GJ_2014_v1.CSV')
NHIS2015 = read.csv('data/NHIS/NHIS_OPEN_GJ_2015_v1.CSV')
NHIS2016 = read.csv('data/NHIS/NHIS_OPEN_GJ_2016_v1.CSV')

#02
str(NHIS2002)
head(NHIS2002)
table(is.na(NHIS2002))
N2002 = na.omit(NHIS2002)
head(N2002)
glimpse(N2002)
as.factor(N2002$결손치유무)
is.na(N2002)
table(is.na(N2002))
str(N2002)

# 03
N2002 %>% group_by(성별코드, 연령대코드.5세단위.) %>% summary()

# 05
