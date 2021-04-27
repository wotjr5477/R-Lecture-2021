# 210427

str(anscombe)
head(anscombe)

# 평균
apply(anscombe, 2, mean)

# 분산
apply(anscombe, 2, var)

# 상관관관계
for (i in 1:4) {
  ans_cor = cor(anscombe[,i], anscombe[,i+4])
  print(ans_cor)
}

# 요약
summary(anscombe)


# 데이터 시각화
library(gapminder)
library(dplyr)

y = gapminder %>%
  group_by(year, continent) %>%
  summarize(c_pop = sum(pop))
head(y,10)

# 1단계 - 막 그래프(막 그렸다는 뜻;;)
plot(y$year, y$c_pop)

# 2단계 - 마커의 색상을 대륙별로 지정
plot(y$year, y$c_pop, col=y$continent)

# 3단계 - 마커의 모양을 대륙별로 다르게 지정
plot(y$year, y$c_pop, col=y$continent, pch=c(1:5))
length(levels(y$continent))
plot(y$year, y$c_pop, col=y$continent,pch=c(1:length(levels(y$continent))))

# 4단계 - 범례 표시
legend("topleft", legend=levels(y$continent), pch=c(1:length(levels(y$continent))),
       col = c(1:length(levels(y$continent))))

# 대륙별 연령, GDP, 기대수명
plot(gapminder$gdpPercap, gapminder$lifeExp, pch=c(1:length(levels(gapminder$continent))), col=gapminder$continent)
legend("bottomright",
       legend=levels(gapminder$continent), pch=c(1:length(levels(gapminder$continent))), col=gapminder$continent)


# ggplot을 이용해서 그려보기
library(ggplot2)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent)) + geom_point() + scale_x_log10()

# 인구수에 따른 포인트 크기 조절       
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size=pop)) +
  geom_point() + scale_x_log10()

# 포인트의 투명도 조절
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size=pop)) +
  geom_point(alpha=0.5) + scale_x_log10()

# 2007년도 자료만 보기
library(dplyr)
gapminder %>% filter(year==2007) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, col=continent, size=pop)) +
  geom_point(alpha=0.5) + scale_x_log10()

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, col=continent, size=pop))


# 시각화 기본기능
# 1.q 비교/순위
gapminder %>%
  filter(continent=="Asia"&year==1952) %>%
  ggplot(aes(reorder(country, pop),pop)) + geom_bar(stat="identity") + coord_flip()

gapminder %>%
  filter(continent=="Asia"&year==1952) %>%
  ggplot(aes(reorder(country, pop),pop)) + geom_bar(stat="identity") + scale_y_log10() + coord_flip()

# 3. 변화 추세
gapminder %>%
  filter(country=="Korea, Rep.") %>%
  ggplot(aes(year, lifeExp, col=country)) + geom_point() + geom_line()

# 4 여러 데이터의 변화 추세
ggplot(gapminder, aes(year, lifeExp, col=continent)) + geom_point(alpha=0.2) + geom_smooth() # 밴드 : 95% 신뢰구간

# 5. 분포
x = filter(gapminder, year==1952)
hist(x$lifeExp, main="Histogram of lifeExp in 1952")

x %>% ggplot(aes(lifeExp)) + geom_histogram()

# 6. 대륙별 세분화된 분포 특성 : boxplot
x %>% 
  ggplot(aes(continent, lifeExp)) + geom_boxplot()

# 7. 상관 관계
plot(log10(gapminder$gdpPercap), gapminder$lifeExp)
