install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

data(package='arules')
data('Mushroom')
class(Mushroom)

#investigate
inspect(head(Mushroom)) 
inspect(tail(Mushroom))

size(head(Mushroom))   #top 6 transactions have a size of 22,23...
size(tail(Mushroom))

LIST(head(Mushroom, 2))

#freq item set
frequentitems <- eclat(Mushroom, parameter = list(supp=.7,minlen=3))
inspect(head(sort(frequentitems, by="supp"), 10))

#visualize freq items
itemFrequencyPlot(Mushroom, topN=10, type='absolute')

#rules
rules <- apriori(Mushroom, parameter = list(supp=.9, conf=.9,minlen=2))
rules
inspect(rules)

lift<-subset(rules, lift>1)
lift
inspect(lift)

rules <- apriori(Mushroom, parameter = list(supp=.7, conf=.8,minlen=2),
                 appearance = list(default='lhs', rhs='VeilColor=white'))
rules
inspect(rules)

plot(rules, method='graph')


