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

# 2. pie, / bar plot
pie(x$gdp, x$country)
barplot(x$gdp, names.arg=x$country)

#3. matplot
head(iris)
glimpse(iris)

matplot(iris[,1:4], type="l")
legend("topleft", names(iris)[1:4], lty=c(1:4), col=c(1:4))

# 4. hist - 히스토그램
hist(cars$speed)
hist(iris$Sepal.Length)


# ggplot2 라이브러리
# 1. geom_histogram
gapminder %>% filter(year==2007) %>%
  ggplot(aes(lifeExp, col=continent)) + geom_histogram()

gapminder %>% filter(year==2007) %>%
  ggplot(aes(lifeExp, col=continent)) + geom_histogram(position="dodge")

#  2. geom_boxpot
gapminder %>% filter(year==2007) %>%
  ggplot(aes(continent, lifeExp, col=continent)) + geom_boxplot()

gapminder %>% filter(year==2007) %>%
  ggplot(aes(lifeExp, col=continent)) + geom_boxplot()

# 3. scale_x_log10(), scale_y_log10()
ggplot(gapminder, aes(gdpPercap, lifeExp, col=continent)) + geom_point(alpha=0.2)
ggplot(gapminder, aes(gdpPercap, lifeExp, col=continent)) + geom_point(alpha=0.2) + scale_x_log10()

# 4. coord_flip()
gapminder %>% filter(continent=="Africa") %>%
  ggplot(aes(country, lifeExp, col=country)) + geom_bar(stat="identity")
gapminder %>% filter(continent=="Africa") %>%
  ggplot(aes(country, lifeExp, col=country)) + geom_bar(stat="identity") + coord_flip()

# 5. scale_fill
library(RColorBrewer)
display.brewer.all()

gapminder %>% filter(lifeExp > 70) %>% group_by(continent) %>% summarize(n=n_distinct(country)) %>% ggplot(aes(x=continent, y=n)) + geom_bar(stat="identity", aes(fill=continent))

# spectral 팔레트
