# 210426

# dplyr 연습문제
library(dplyr)
library(ggplot2)
?mpg

head(mpg)

# 1
mpg %>% filter(displ <= 4) %>% select(model,year, displ,hwy) %>% summarize(mh = mean(hwy)) # 26.0
mpg %>% filter(displ >= 5) %>% select(model,year, displ,hwy) %>% summarize(mh = mean(hwy)) #18.1

# 2
mpg %>% filter(manufacturer == "audi") %>% select(model,year, displ, cty) %>% summarize(mc = mean(cty)) # 17.6
mpg %>% filter(manufacturer == "toyota") %>% select(model,year, displ, cty) %>% summarize(mc = mean(cty)) # 18.5

# 3
(cfh = mpg %>% filter(manufacturer == "chevrolet" | manufacturer == "ford" | manufacturer == "honda") %>% select(model,year, displ, hwy))
cfh %>% summarize(mean(hwy))

# 4
(mpgNEW = data.frame(mpg %>% select(class, cty)))
str(mpgNEW)

# 5
mpgNEW %>% filter(class == "suv" | class == "compact") %>% group_by(class) %>% summarize(mean(cty))

# 6
mpg %>% filter(manufacturer == "audi") %>% select(model, year, hwy) %>% arrange(desc(hwy)) %>% head(5)

# 7 
## 1)
mpg_copy = mpg
mpg_copy$ce = mpg_copy$hwy + mpg_copy$cty
## 2)
mpg_copy$mce = mpg_copy$ce/2
## 3)
mpg_copy %>%
  select(manufacturer, model, mce)%>% 
  arrange(desc(mce)) %>% head(3)
## 4)
mpg %>% summarize(manufacturer, model, mce=(cty+hwy)/2) %>% 
  arrange(desc(mce)) %>% head(3)
  
# 8
mpg %>% group_by(class) %>% summarize(mc=mean(cty))


# 9
mpg %>% group_by(class) %>% summarize(mc=mean(cty)) %>% arrange(desc(mc))

# 10
mpg %>% group_by(manufacturer) %>% summarize(mh=mean(hwy)) %>% arrange(desc(mh)) %>% head(3)

# 11
mpg %>% group_by(manufacturer) %>% filter(class == "compact") %>% summarize(n=n()) %>% arrange(desc(n))

                                                                                               