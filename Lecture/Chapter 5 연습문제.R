# 210426

# Chapter 5 연습문제

# p.154
# 1
library(gapminder)
filter(gapminder, continent == "Asia") %>% 
  group_by(country) %>% summarize(pop_avg=mean(pop)) %>% head(20)

"Korea, Rep."

K_pop = gapminder %>%
  filter(country == "Korea, Rep.") %>%
  select(pop)
max(K_pop)  

#gapminder %>% filter(country == "Korea, Rep.") %>% select(pop)
#filter(gapminder, country=="Korea, Rep.") %>% select(pop)

max(filter(gapminder, country=="Korea, Rep.") %>% select(pop))

# 2
gapminder %>% filter(continent=="Asia") %>% group_by(country) %>% summarize(pop_sum=sum(pop))
sum(gapminder %>% filter(continent=="Asia") %>% group_by(country) %>% summarize(pop_sum=sum(pop))%>%select(pop_sum))
sum(gapminder %>% filter(continent=="Asia") %>% select(pop))

# p.160
# 1
glimpse(gapminder)
gapminder %>% filter(country=="Korea, Rep." | country=="China" | country=="Japan") %>% group_by(country) %>% summarize(year, gdpPercap) %>% head(36)
