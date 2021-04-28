# 210428

# Chapter 6 시각화 심화
library(ggplot2)
library(dplyr)


# 1.
## mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요.
head(mpg)
mpg %>% ggplot(aes(cty,hwy,col=class)) + geom_point()

# 2.
## 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.
head(midwest)
dim(midwest)
colnames(midwest)
midwest %>% filter(poptotal<=500000, popasian<=10000) %>% select(state, poptotal, popasian) %>% ggplot(aes(poptotal,popasian,col=state)) + geom_point()

 
# 3.
##어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv" 차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요. 
head(mpg)
mpg %>%
  filter(class=="suv") %>% group_by(manufacturer) %>% 
  summarize(mcty=mean(cty)) %>% arrange(desc(mcty)) %>% head(5) %>%
  ggplot(aes(reorder(manufacturer,-mcty), mcty)) + 
  geom_bar(stat="identity", aes(fill=manufacturer)) + 
  scale_fill_brewer(palette = "Spectral") +
  labs(title="suv 도시연비 Top 5", x="제조사", y="평균도시연비",fill="제조사")


# 4.
## 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
mpg %>% group_by(class) %>% summarize(n=n()) %>%
  ggplot(aes(class,n)) + 
  geom_bar(stat="identity", aes(fill=class)) + 
  scale_fill_brewer(palette = "Spectral") +
  labs(title="차종별 수량", x="차종", y="수량",fill="차종")
  

# 5.
# economics 데이터를 이용해서 psavert(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.
economics %>% ggplot(aes(date, psavert)) + geom_line()


# 6.
# class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어보세요.
mpg %>% filter(class %in% c("compact","subcompact","suv")) %>% group_by(class) %>% summarize(cty) %>% ggplot(aes(class, cty)) + geom_boxplot()


# 7.
## Diamonds 데이터 셋을 이용하여 다음 문제를 해결하세요. 단, 컬러, 제목, x축, y축 등 그래프를 예쁘게 작성하세요.
head(diamonds); str(diamonds)
### 1) cut의 돗수를 보여주는 그래프를 작성하세요.
diamonds %>% group_by(cut) %>% summarize(n=n()) %>% ggplot(aes(cut, n)) +
  geom_bar(stat="identity", aes(fill=cut)) + 
  scale_fill_brewer(palette = "Blues")
### 2) cut에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
diamonds %>% group_by(cut) %>% ggplot(aes(cut,price)) + geom_point()
diamonds %>% group_by(cut) %>% summarize(avg_price=mean(price)) %>% ggplot(aes(cut,avg_price)) + geom_histogram(stat="identity", aes(fill=cut)) + 
  scale_fill_brewer(palette = "Blues")
### 3) cut과 color에 따른 가격의 변화를 보여주는 그래프를 작성하세요.
