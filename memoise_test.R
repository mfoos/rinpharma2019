library(memoise)

fc <- cache_filesystem("~/.cache")
mrunif <- memoise(runif, cache = fc)

helper <- function(x){
  runif(x)
}

leader <- function(x, y){
  helper(x) + y
}

leader2 <- function(x, y){
  helper(x) - y
}

mleader <- memoise(leader, cache = fc)
mleader(10000000, 5) # slow
mleader(10000000, 5) # fast
mleader(10000000, 1) # slow
leader2(10000000, 3) # fast
leader2(10000000, 1) # fast
forget(mleader)

mhelper <- memoise(helper, cache = fc)
leader <- function(x, y){
  mhelper(x) + y
}

leader2 <- function(x, y){
  mhelper(x) - y
}

leader(10000000, 5) # slow
leader(10000000, 5) # fast
leader(10000000, 1) # fast
leader2(10000000, 3) # fast
leader2(10000000, 1) # fast
