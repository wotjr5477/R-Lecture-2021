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
sum(gapminder %>% filter(continent=="Asia" & year==2007) %>% summarize(pop_sum=sum(pop))%>%select(pop_sum))
sum(gapminder %>% filter(continent=="Asia") %>% select(pop))

# p.160
# 1
glimpse(gapminder)
(KCJ_gdp = gapminder %>% filter(country=="Korea, Rep." | country=="China" | country=="Japan") %>% group_by(year) %>% summarize(country, year, gdpPercap))

# 2
AEdiff = gapminder %>% filter(continent=="Africa" | continent=="Europe") %>% group_by(year, continent) %>% summarize(pop_sum=sum(pop))
AEdiff[1,]
AEdiff[2,]
AEdiff[,1]
AEdiff[2,3]

dfA = gapminder %>% filter(continent=="Africa") %>% group_by(year) %>% summarize(pop_sum=sum(pop)); dfA
dfE = gapminder %>% filter(continent=="Europe") %>% group_by(year) %>% summarize(pop_sum=sum(pop)); dfE
dfAE = merge(dfA, dfE, by="year"); dfAE
names(dfAE) = c("year", "Africa","Europe")
dfAE

comp = function(x) {
  gap = dfAE[x,2]-dfAE[x,3]
  if (gap > 0) print(dfAE[x,1])
}

for (i in 1:nrow(dfAE)) {
  comp(i);
}

# 3
gu = gapminder_unfiltered
head(gu)
str(gu)
gu %>% filter(continent=="Asia") %>% group_by(country) %>% summarize(country, year)
n=n()
gu %>% group_by(country) %>% summarize(ob_times = n()) %>% filter(ob_times >= 12) %>% arrange(desc(ob_times))
