# 210427

# ggplot2 연습문제

# 1
?iris
str(iris)
head(iris)

iris %>% group_by(Species) %>% summarize()

ss = iris %>% filter(Species=="setosa") %>%
  select(Sepal.Length, Sepal.Width, Species); ss
sp = iris %>% filter(Species=="setosa") %>%
  select(Petal.Length, Petal.Width, Species)

ves = iris %>% filter(Species=="versicolor") %>%
  select(Sepal.Length, Sepal.Width, Species)
vep = iris %>% filter(Species=="versicolor") %>%
  select(Petal.Length, Petal.Width, Species)

vis = iris %>% filter(Species=="virginica") %>%
  select(Sepal.Length, Sepal.Width, Species)
vip = iris %>% filter(Species=="virginica") %>%
  select(Petal.Length, Petal.Width, Species)

# setosa 품종
## Sepal.Length/Width 산점도
ss %>% ggplot(aes(Sepal.Length, Sepal.Width)) + 
  geom_point()
sp %>% ggplot(aes(Petal.Length, Petal.Width)) + 
  geom_point()

# versicolor 품종
## Sepal.Length/Width 산점도
ves %>% ggplot(aes(Sepal.Length, Sepal.Width)) + 
  geom_point()
vep %>% ggplot(aes(Petal.Length, Petal.Width)) + 
  geom_point()

# viginica 품종
## Sepal.Length/Width 산점도
vis %>% ggplot(aes(Sepal.Length, Sepal.Width)) + 
  geom_point()
vip %>% ggplot(aes(Petal.Length, Petal.Width)) + 
  geom_point()


# 2
# 품종별 평균
mss = ss %>% summarize(meanSL=mean(Sepal.Length), meanSW=mean(Sepal.Width))
mves = ves %>% summarize(meanSL=mean(Sepal.Length), meanSW=mean(Sepal.Width))
mvis = vis %>% summarize(meanSL=mean(Sepal.Length), meanSW=mean(Sepal.Width))

msp = sp %>% summarize(meanPL=mean(Petal.Length), meanPW=mean(Petal.Width))
mvep = vep %>% summarize(meanPL=mean(Petal.Length), meanPW=mean(Petal.Width))
mvip = vip %>% summarize(meanPL=mean(Petal.Length), meanPW=mean(Petal.Width))
data.frame(join(c(mss,mves,mvis,msp,mvep,mvip), by() ))
ggplot(data=c(mss,mves,mvis,msp,mvep,mvip))
head(iris)
# 3
iris %>% ggplot(aes(Species, Sepal.Length)) + geom_boxplot()

   