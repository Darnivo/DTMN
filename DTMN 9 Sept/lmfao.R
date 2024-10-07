a = 5
b <- 5
5 -> c

string = "Hello world"
boolol = TRUE
#yes

boolol = !boolol

#non scalar 
# ^ vars which are non singular (e.g matrix / vector / factor)

vect = c(14,23,45,67,89)


vect[3]


vect2 = c(1:20)

data = c(1,1,1,1,2,2,2,2,2,4,5,6,6,7,7,7)

#freq of data
table(data)

#factor > encodes data 
names = c("abdul","ahmed","zulfaker","yussef","mahmoud")
fact = factor(names)
fact


str(fact)


matr = matrix(1:12, nrow=3,ncol=4)
matr
str(matr)

matr[1,3]

matr2 = t(matr)
matr2

#in cli > getwd()
# also setwd("D:/")

#remove(poke)
poke = read.csv("./pokemon.csv", sep =",", stringsAsFactors = T)
poke

str(poke)

str(poke$Type)

table(poke$HP)

rm(value)

i=1
while(i<5){
  print(i)
  i=i+1
}

if(a>5){
  print("yes")
}else{
  print("no")
}

ifelse(a>1,print("yes"),print("no"))

ifelse(a>10,print("yes"),print("no"))

#right click to focus
test = function(){
  print("yea!")
}

test()

addAB = function(num1,num2){
  return (num1 + num2)
}

print(addAB(a,51))


#type cast
z=5
chZ = as.character(z)

chZ

intZ = as.integer(chZ)
intZ
