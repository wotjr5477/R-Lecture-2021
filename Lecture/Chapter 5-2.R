# 210426


# dplyr을 이용한 데이터 가공
# filter, select, arrange, group_by/summarize, mutate

library(dplyr)
library(gapminder)

gapminder

# 1. select
select(gapminder, country, year, lifeExp)
select(gapminder, country, year, lifeExp) %>% head()
select(gapminder, country, year, lifeExp) %>% head(8)

# 2. filter : 원하는 행을 추출
filter(gapminder, country=="Croatia")
filter(gapminder, country=="Croatia" & year > 2000)
filter(gapminder, country=="Croatia" & year == 2007)

# 3. arrange : 
europe_pop = filter(gapminder, continent=="Europe" & year == 2007); europe_pop
arrange(europe_pop, lifeExp) # 오름차순이 기본
arrange(europe_pop, desc(lifeExp)) # 내림차순

# 아프리카에서 평균 수명이 가장 긴 나라 Top 5
africa_pop = filter(gapminder, continent=="Africa" & year == 2007)

filter(gapminder, continent=="Africa" & year == 2007) %>%
  arrange(desc(lifeExp)) %>% 
  head(5)

gapminder %>%
  filter(continent=="Africa" & year == 2007) %>%
         arrange(desc(lifeExp)) %>%
           head(5)

# 4. group_by 와 summarize
summarize(africa_pop, pop_avg=mean(pop)) # 2007년 아프리카 국가별 인구수 평균
summarize(group_by(gapminder, continent), pop_avg=mean(pop)) 
summarize(group_by(gapminder, country), life_avg=mean(lifeExp)) 


asia = gapminder %>%
  filter(continent=="Asia")
summarize(group_by(asia, country), life_avg = mean(lifeExp))
summarize(group_by(asia, country), life_avg = mean(lifeExp)) %>%
  arrange(desc(life_avg))
summarize(group_by(asia, country), life_avg = mean(lifeExp)) %>%
  arrange(desc(life_avg)) %>%
  head(5)
 