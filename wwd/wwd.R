### R code from vignette source 'wwd.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: prelim
###################################################
library(ALKr)

stampIt=function(...){
   require(plyr)

   args=list(...)
   
   ldply(args, function(x) { res=packageDescription(x)
                            c(Package=x,
                              Version=packageDescription("ALKr")$Version,
                              Date   =packageDescription("ALKr")$Date)})}

smry=stampIt("ALKr")

theme_ms <- function(base_size = 12, base_family = "",...) { 
  # Starts with theme_grey and then modify some parts 
  res=theme_grey(base_size = base_size, base_family   = base_family) %+replace% 
    theme(axis.text         = element_text(                                     size   = rel(0.8)), 
          axis.ticks        = element_line(                 colour = "black"), 
          legend.key        = element_rect(                 colour = "grey80"), 
          panel.background  = element_rect(fill = "white",  colour = NA), 
          panel.border      = element_rect(fill = NA,       colour = "grey50"), 
          panel.grid.major  = element_line(                 colour = "grey90",  size = 0.2), 
          panel.grid.minor  = element_line(                 colour = "grey98",  size = 0.5), 
          strip.background  = element_rect(fill = "grey80", colour = "grey50"), 
          strip.background  = element_rect(fill = "grey80", colour = "grey50")) 
  
  modifyList(res, list(...))} 


###################################################
### code chunk number 2: wwd.Rnw:147-148 (eval = FALSE)
###################################################
## ?history


###################################################
### code chunk number 3: wwd.Rnw:165-174
###################################################
x = array(rnorm(9),dim=c(3,3),
                   dimnames=list(row=c("x","y","z"),col=1:3))
x

# what is it?
class(x)
typeof(x)
mode(x)
is(x)


###################################################
### code chunk number 4: wwd.Rnw:189-193
###################################################
b = 1:5
length(b)
b
b^2


###################################################
### code chunk number 5: wwd.Rnw:204-205
###################################################
log(b)


###################################################
### code chunk number 6: wwd.Rnw:221-222
###################################################
plot(b)


###################################################
### code chunk number 7: wwd.Rnw:237-243
###################################################
# recycling
a = 1:6
b = 1:3
a + b
c = 1:4
a + c


###################################################
### code chunk number 8: wwd.Rnw:253-258
###################################################
a = c(3, 4, NA, Inf)
a
tt = c(1, NA, 3, 4, NA, 6, NaN)
is.na(tt)
is.nan(tt)


###################################################
### code chunk number 9: wwd.Rnw:265-268
###################################################
a=1
sum(a)
sum(a, na.rm = T)


###################################################
### code chunk number 10: wwd.Rnw:274-277
###################################################
a=1
sum(a)
sum(a, na.rm = T)


###################################################
### code chunk number 11: wwd.Rnw:284-288
###################################################
b = c("yes", "no", "maybe")
paste("is it", b)
paste("is it", b, sep = ",")
paste("is it", b, sep = " ", collapse = ", ")


###################################################
### code chunk number 12: wwd.Rnw:296-297
###################################################
a = rnorm(100)


###################################################
### code chunk number 13: wwd.Rnw:304-314 (eval = FALSE)
###################################################
## mean(a)
## sd(a)
## plot(a)
## hist(a)
## boxplot(a)
## boxplot(a, col="red")
## qqnorm(a)
## qqline(a)
## fivenum(a)
## stem(a)


###################################################
### code chunk number 14: wwd.Rnw:322-324
###################################################
max(a)
pmax(a, 0)


###################################################
### code chunk number 15: wwd.Rnw:331-333
###################################################
c(T, F, T, T, F, F) == TRUE
!c(T, F, T, T, F, F)


###################################################
### code chunk number 16: wwd.Rnw:342-347
###################################################
a = c(T, T, F, F, T)
b = 1:5
b[a]
b[b > 2]
b[1:3]


###################################################
### code chunk number 17: wwd.Rnw:354-356
###################################################
b[c(1, 2, 1, 3, 4, 1, 1, 5)]
b[-3]


###################################################
### code chunk number 18: wwd.Rnw:364-367
###################################################
b = c(0, b)
lb = as.logical(b)
lb


###################################################
### code chunk number 19: wwd.Rnw:379-382
###################################################
# create an array
x = array(rnorm(9),dim=c(3,3),
                    dimnames=list(row=c("x","y","z"),col=1:3))


###################################################
### code chunk number 20: wwd.Rnw:392-402
###################################################
# dimensions
dim(x)
dimnames(x)
attributes(x)

# alternatives for creating an array
a = matrix(1:16, nrow = 4)
aa= matrix(1:16, nrow = 4, byrow = TRUE)
a
aa


###################################################
### code chunk number 21: wwd.Rnw:409-422
###################################################
# changing attributes
a=1
dim(a) = NULL
attributes(a)
a

attr(aa, "dim") = c(2, 4, 2)
attributes(aa)
aa

aa[2, 3,1]
aa[2,,]
aa[1:2,, ]


###################################################
### code chunk number 22: wwd.Rnw:431-433
###################################################
fish = list(name = "cod", age = 3, male = FALSE)
fish


###################################################
### code chunk number 23: wwd.Rnw:440-443
###################################################
fish$name
fish[["name"]]
fish[[1]]


###################################################
### code chunk number 24: wwd.Rnw:451-455
###################################################
class(fish$name)
class(fish[["name"]])
class(fish[[1]])
class(fish[1])


###################################################
### code chunk number 25: wwd.Rnw:463-464
###################################################
array(list(), c(2, 3))


###################################################
### code chunk number 26: wwd.Rnw:474-478
###################################################
a = list(age = 1:10, weight = c(0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.6, 0.7, 0.9))
a
b = as.data.frame(a)
b


###################################################
### code chunk number 27: wwd.Rnw:486-488
###################################################
fish = list(name = "cod", age = 3, male = FALSE)
fish


###################################################
### code chunk number 28: wwd.Rnw:496-499
###################################################
fish$name
fish[["name"]]
fish[[1]]


###################################################
### code chunk number 29: wwd.Rnw:505-510
###################################################
class(fish$name)
class(fish[["name"]])
class(fish[[1]])
class(fish[1])
attr(fish, "rem") = "This is my dataframe"


###################################################
### code chunk number 30: wwd.Rnw:518-522
###################################################
args(fix)
write.table(b, )
args(write.table)
args(read.table)


###################################################
### code chunk number 31: wwd.Rnw:535-539
###################################################
as.double("2")
as.character(2)
df = data.frame(string = c("eeny", "meeny", "miny", "mo"), integer = 1:4)
as.matrix(df)


###################################################
### code chunk number 32: wwd.Rnw:571-577 (eval = FALSE)
###################################################
## dirData=paste(system.file(package="saCourse", mustWork=TRUE),"examples",sep="/")
## 
## ## read.csv
## fileCdis =paste(dirData,"cdis.csv",sep="")
## cdis=read.csv(fileCdis)
## head(cdis)


###################################################
### code chunk number 33: wwd.Rnw:585-588 (eval = FALSE)
###################################################
## nao =read.table("http://www.cdc.noaa.gov/data/correlation/nao.data", skip=1,
## nrow=62,
## na.strings="-99.90")


###################################################
### code chunk number 34: wwd.Rnw:597-603 (eval = FALSE)
###################################################
## fileSwo="swoCN.dat"
## yrs =scan(fileSwo,skip=2,nlines=1)
## ages=scan(fileSwo,skip=3,nlines=1)
## dat =scan(fileSwo,skip=5)
## caa =array(dat,dim     =c(diff(ages)+1, diff(yrs)+1),
##                dimnames=list(age =ages[1]:ages[2],year=yrs[1]:yrs[2]))


###################################################
### code chunk number 35: wwd.Rnw:618-636 (eval = FALSE)
###################################################
## install.packages('gdata')
## library(gdata)
## yrs =read.xls("swordfish.xls",sheet="CatchN",skip=1,nrow=1)[1:2]
## ages =read.xls("swordfish.xls",sheet="CatchN",skip=2,nrow=1)[1:2]
## dat =read.xls("swordfish.xls",sheet="CatchN",skip=5,header=F)
## caaXl=array(dat,dim
## =c(diff(ages)+1, diff(yrs)+1),
## dimnames=list(age =ages[1]:ages[2],year=yrs[1]:yrs[2]))
## is(ages)
## is(yrs)
## is(dat)
## ages=unlist(ages)
## yrs =unlist(yrs)
## dat =t(as.matrix(dat))
## caaXl=array(dat,dim
## =c(diff(ages)+1, diff(yrs)+1),
## dimnames=list(age =ages[1]:ages[2],year=yrs[1]:yrs[2]))
## caaXl


###################################################
### code chunk number 36: wwd.Rnw:651-665 (eval = FALSE)
###################################################
## chlT3sz   =odbcConnectAccess(fileT3sz)
## sqlTables(chlT3sz)
## t3sz     = sqlQuery(chlT3sz, "select * from [t2szFreqs]")
## head( t3sz)
## names(t3sz)
## 
## head(sqlQuery(chlT3sz, "select * from [Species]"))
## head(sqlQuery(chlT3sz, "select * from [t2szFreqs]"))
## head(sqlQuery(chlT3sz, "select * from [t2szProcs]"))
## head(sqlQuery(chlT3sz, "select * from [t2szStrata]"))
## head(sqlQuery(chlT3sz, "select * from [cat_szDetail]"))
## head(sqlQuery(chlT3sz, "select * from [cat_szSummary]"))
## head(sqlQuery(chlT3sz, "select * from [subSets]"))
## head(sqlQuery(chlT3sz, "select * from [t2szProcs Query]"))


###################################################
### code chunk number 37: wwd.Rnw:673-685 (eval = FALSE)
###################################################
## library(RSQLite)
## ## Initialise the SQLite engine
## SQLite()
## ## connect DB
## dbMC ="c:/temp/t.dbf"
## conMC =dbConnect(dbDriver("SQLite"), dbname=dbMC)
## df=data.frame(n=rep(1:4,25),a=rep(c("a","b","c","d"),each=25))
## dbWriteTable(conMC,"EastMC",df,append=TRUE)
## dbListTables(conMC)
## file.info(dbMC)
## query="SELECT * FROM 'EastMC' WHERE n IN (2) AND a IN ('a','b') LIMIT 10"
## x= dbGetQuery(conMC, query)


###################################################
### code chunk number 38: wwd.Rnw:692-704 (eval = FALSE)
###################################################
## setGeneric("sqlVar", function(object, ...)
## standardGeneric("sqlVar"))
## setMethod("sqlVar", signature("character"),
## function(object, ...) paste("('",paste(object,collapse="','"),"')",sep=""))
## setMethod("sqlVar", signature("numeric"),
## function(object, ...) paste("(",paste(object,collapse=","),")",sep=""))
## sqlVar(c("b"))
## sqlVar(2)
## query= paste("SELECT * FROM 'EastMC' WHERE n IN", sqlVar(2), "AND a IN", sqlVar(c("a","b")), "LIMIT
## 10")
## x= dbGetQuery(conMC, query)
## dbDisconnect(conMC)


###################################################
### code chunk number 39: wwd.Rnw:733-735 (eval = FALSE)
###################################################
## ?apply
## example(apply)


###################################################
### code chunk number 40: wwd.Rnw:745-747 (eval = FALSE)
###################################################
## ?sweep
## example(sweep)


###################################################
### code chunk number 41: wwd.Rnw:767-769 (eval = FALSE)
###################################################
## for (i in 1:length(x))
## x[i] = x[i] + 2


###################################################
### code chunk number 42: wwd.Rnw:777-779 (eval = FALSE)
###################################################
## x = c(2, 3, 4, 5)
## x + 2


###################################################
### code chunk number 43: wwd.Rnw:789-796 (eval = FALSE)
###################################################
## cube = function(x, na.rm = TRUE) {
## if (na.rm == TRUE)
## x = x[!is.na(x)]
## return(x^3)
## }
## a = 1:5
## cube(a)


###################################################
### code chunk number 44: wwd.Rnw:806-807 (eval = FALSE)
###################################################
## args(cube)


###################################################
### code chunk number 45: wwd.Rnw:815-823 (eval = FALSE)
###################################################
## err = function(a){
##     loga = log(a[,1])
##     
##     res  = mean(log(a))
##     
##     return(res)}
## 
## err(rnorm(5,0,1))


###################################################
### code chunk number 46: wwd.Rnw:841-849 (eval = FALSE)
###################################################
## err2 = function(a,b){
## browser()
## v1 = mean(a)
## v2 = median(a)
## loga = log(a[,1])
## res= mean(log(a))
## return(res)}
## err2(rnorm(5,0,1))


###################################################
### code chunk number 47: wwd.Rnw:860-865 (eval = FALSE)
###################################################
## install.packages('debug')
## library(debug)
## mtrace(err)
## err(rnorm(5,0,1))
## mtrace.off(err)


