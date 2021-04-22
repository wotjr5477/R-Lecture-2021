#210422


# 파일 읽기
a = choose.files()

students = read.table(file = 'data\\students1.txt')
students
str(students)

# read.csv 는 첫 행을 헤더로 읽는다(디폴트)
students = read.csv('data\\students.csv')
students
str(students)

# 파일 쓰기 / encoding 신경 쓸 것
write.table(students, file = 'data/output1.txt')
write.table(students, file = 'data/output1.txt', fileEncoding = 'utf-8')

write.csv(students, file = 'data/output1.csv')
write.csv(students, file = 'data/output1.csv', fileEncoding = 'utf-8')
write.csv(students, file = 'data/output1.csv', fileEncoding = 'utf-8', row.names = F)


# quote = F option
write.table(students, file = 'data/output1.txt', fileEncoding = 'utf-8', row.names = F, quote = F)

write.csv(students, file = 'data/output1.csv', fileEncoding = 'utf-8', row.names = F, quote = F)


# 확인
students = read.csv(file='data/output1.csv')
students = read.csv(file='data/output1.csv', fileEncoding = 'utf-8')
students = read.table(file='data/output1.txt', fill=T)
students = read.table(file='data/output1.txt', fill = T)
students = read.table(file='data/output1.txt',header = T, fileEncoding = 'utf-8')
students
str(students)
