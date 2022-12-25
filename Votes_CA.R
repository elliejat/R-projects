install.packages("cluster")
install.packages("factoextra")

library(cluster)
library(factoextra)

data(package='cluster')
data("votes.repub")
View(votes.repub)
head(votes.repub)
summary(votes.repub)

votes.repub <- na.omit(votes.repub)
votes.repub <- scale(votes.repub)
votes.repub

dist <- factoextra::get_dist(votes.repub, method = 'pearson')
dist
factoextra::fviz_dist(dist)

#Hierarchical clustering
hc1 <- cluster::agnes(votes.repub, method = 'single')
hc1
hc1$ac

hc2 <- cluster::agnes(votes.repub, method = 'complete')
hc2
hc2$ac

hc3 <- cluster::agnes(votes.repub, method = 'average')
hc3

hc1$ac
hc2$ac
hc3$ac

plot(hc2)



