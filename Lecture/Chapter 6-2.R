# 210427
library(ggplot2)
library(dplyr)
library(gapminder)

# 시각화 도구
# 1. plot
head(cars)
plot(cars, type="p", main="cars") # p-point, main -title
plot(cars, type="l", main="cars") # l-line
plot(cars, type="b", main="cars") # both point & line
plot(cars, type="h", main="cars") # 히스토그램과 같은

x = gapminder %>% filter(year==1952 & continent=="Asia") %>%
  mutate(gdp=gdpPercap*pop) %>%
  select(country, gdp) %>% arrange(desc(gdp)) %>% head(); x

pie(x$gdp, x$country)
