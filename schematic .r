install(tree)
install(maptree)
library(tree)
ir.tr<-tree(Scecies~., iris)
plot(ir.tr, type="uniform")
next(ir.tr)
library(maptree)
draw.tree(ir.tr)