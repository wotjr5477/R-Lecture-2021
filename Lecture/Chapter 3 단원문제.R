#210422

#Chapter 4 단원문제

#1
x=seq(1,100); x=x[x%%3==0]
x

y=seq(1,100); y=y[y%%4==0]
y

#2
z = intersect(x,y); z # x,y의 교집합
sum(z) # 교집합 내 원소의 합

#3
?airquality # >> New York Air Quality Measurements, 1973

#4
?airquality # >> Temp : numeric Temperature(degree F) >> Fahrenheit

#5
airquality[airquality$Wind == max(airquality$Wind),] # June 17, 1973

#6
is.na(airquality)
sum(is.na(airquality)) # 44

#7
?quakes # >> Locations of Earthquakes off Fiji, 1964

#8
head(quakes)
max(quakes$mag) # 6.4
