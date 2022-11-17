install.packages('arules')
install.packages('arulesViz')

library(arules)
library(arulesViz)

getwd()
data(package='arules')

data('Income')
class(Income)

#investigate
inspect(head(Income))
inspect(tail(Income))

size(head(Income))
size(tail(Income))

list(head(Income))
list(head(Income,1))

frequentItemset <-eclat(Income, parameter=list(sup= 0.5, maxlen=15))
#support greater than 50%, maxlen refers to how many transactions(items), count(freq)
inspect(frequentItemset)   
sort_freq <- sort(frequentItemset, by='support')
#sorts by desc values
inspect(sort_freq)

#visualize frequent items
itemFrequencyPlot(Income,topN=10)
itemFrequencyPlot(Income,topN=10, type= 'absolute')

#create rules
rules<- apriori(Income, parameter= list(supp=0.6, conf=0.8))
rules
rules <- apriori(Income, parameter = list(supp= 0.5, conf=0.7))
rules_sorted <-sort(rules, by='support')
rules_sorted <- sort(rules, by='confidence')
inspect(rules_sorted)
rules_sroted <- sort(rules, by='lift')
inspect(rules_sorted)

rules <- apriori(Income, parameter = list(supp=.5, conf=.7, minlen=3))
rules
inspect(rules)
rules <- apriori(Income, parameter = list(supp=.4, conf=.7, minlen=3))
rules
inspect(rules)

#visualize rules
plot(rules)
plot(rules,interactive= T)

rules_subset <-subset(rules, lift>1.2)
rules_subset
plot(rules_subset)

plot(rules, method = 'matrix')
plot(rules, method = 'graph')
plot(rules_subset, method = 'graph')

#use specific items in the rules
rules <- apriori(Income, parameter = list(supp=.4, conf=.7), 
                 appearance = list(default='lhs',rhs='income=$0-$40,000'))
rules_conf <- sort(rules, by = 'confidence')
inspect(rules_conf)

rules <- apriori(Income, parameter = list(supp=.4, conf=.6), 
                 appearance = list(default='rhs',lhs='number in household=1'))
rules_conf <- sort(rules, by = 'confidence')
inspect(rules_conf)

