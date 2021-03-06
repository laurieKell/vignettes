Albacore North ASPIC assessment
===========================================================================


```r
# sets Rmd options globally
opts_chunk$set(comment = NA, fig.width = 8, fig.height = 5.5, warning = FALSE, 
    message = FALSE, eval = FALSE, echo = TRUE)
```


Initialisation Code
---------------------------------------------------------------------

```r
library(aspic)
dirMy = "/home/laurie/Desktop/flr/git/aspic/inst/etc"
asp = aspic(paste(dirMy, "albn.inp", sep = "/"))
asp = fit(asp)

key = data.frame(name = c("Troll Composite CPUE", "JLL Old", "JLL Modern", "CT Old", 
    "CT Modern"), series = c("I", "I", "II", "I", "II"), flag = c("OT", "JA", 
    "JA", "CT", "CT"), gear = c("TR", "LL", "LL", "LL", "LL"))

dimnames(key)[[1]] = c("Troll Composite CPUE", "JLL Old", "JLL Modern", "CT Old", 
    "CT Modern")

wts = t(array(c(1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1), 
    c(5, 4), list(name = key$name, Scenario = 1:4)))

save(asp, key, wts, file = paste(dirMy, "Data/albn.RData", sep = "/"))
```


CPUE
----------------------------------------------------------------

```r
cpue = subset(diags(asp), !is.na(obs))[, c("year", "name", "obs")]
ggplot(aes(year, obs, group = name, col = name), data = cpue) + geom_point() + 
    stat_smooth() + theme_ms(legend.position = "bottom")
```



```r
library(gam)
gm = gam(log(obs) ~ lo(year) + name, data = cpue)
cpue = data.frame(cpue, gam = predict(gm), gamRsdl = residuals(gm))
scl = coefficients(gm)[3:9]
names(scl) = substr(names(scl), 5, nchar(names(scl)))
cpue = transform(cpue, scl = scl[as.character(name)])
cpue[is.na(cpue$scl), "scl"] = 0

cpue = cbind(cpue, key[cpue$name, ])[, -2]
cpue$name = factor(cpue$name, levels = c("Troll Composite CPUE", "JLL Old", 
    "JLL Modern", "CT Old", "CT Modern"))
ggplot(cpue) + geom_line(aes(year, exp(gam)), col = "red") + geom_smooth(aes(year, 
    obs), se = FALSE) + geom_point(aes(year, obs, col = name)) + facet_wrap(~name, 
    ncol = 1, scale = "free_y") + theme_ms(legend.position = "none") + xlab("Year") + 
    ylab("Index")
```




```r
uMat = ddply(cpue, .(name), transform, obs = stdz(obs))
uMat = cast(uMat, year ~ name, value = "obs")
uMat = uMat[apply(uMat, 1, function(x) !all(is.na(x))), ]

pM = plotmatrix(uMat[, -1])
pM$layers[[2]] = NULL
mns = ddply(subset(pM$data, !(is.na(x) & !is.na(y))), .(xvar, yvar), function(x) mean(x$y, 
    na.rm = T))
pM + geom_hline(aes(yintercept = V1), data = mns, col = "red") + geom_smooth(method = "lm", 
    se = F) + theme(legend.position = "bottom") + xlab("Index") + ylab("Index")
```




```r
cr = cor(uMat[, -1], use = "pairwise.complete.obs")
dimnames(cr) = list(gsub("_", " ", names(uMat)[-1]), gsub("_", " ", names(uMat)[-1]))
cr[is.na(cr)] = 0
corrplot(cr, diag = F, order = "hclust", addrect = 2) + theme(legend.position = "bottom")
```



Fit
----------------------------------------------------------------

```r
plot(asp)
```



Residual Analysis
----------------------------------------------------------------

```r
rsdl = diags(asp)
```


**Observed CPUE verses fitted, blue line is a linear resgression fitted to points, black the y=x line.}**

```r
ggplot(ddply(rsdl, .(name), with, data.frame(obs = stdz(obs), hat = stdz(hat)))) + 
    geom_abline(aes(0, 1)) + geom_point(aes(obs, hat)) + stat_smooth(aes(obs, 
    hat), method = "lm", fill = "blue", alpha = 0.1) + facet_wrap(~name, ncol = 3, 
    scale = "free") + theme_ms(legend.position = "bottom") + xlab("Fitted") + 
    ylab("Observed")
```


**Residuals by year, with lowess smoother and SEs.**

```r
dat = ddply(subset(rsdl, !is.na(residual)), .(name), transform, residual = stdz(residual, 
    na.rm = T))
ggplot(aes(year, residual), data = dat) + geom_hline(aes(yintercept = 0)) + 
    geom_point() + stat_smooth(, method = "loess", se = T, fill = "blue", alpha = 0.1) + 
    facet_wrap(~name, scale = "free_x", ncol = 2)
```


**Plot of autocorrelation, i.e. $residual_{t+1}$ verses $residual_{t}$.**

```r
ggplot(rsdl) + geom_point(aes(residual, residualLag)) + stat_smooth(aes(residual, 
    residualLag), method = "lm", se = T, fill = "blue", alpha = 0.1) + geom_hline(aes(yintercept = 0)) + 
    facet_wrap(~name, scale = "free", ncol = 3) + xlab(expression(Residual[t])) + 
    ylab(expression(Residual[t + 1])) + theme_ms(legend.position = "bottom")
```


**Quantile-quantile plot to compare residual distribution with the normal distribution.**

```r
ggplot(rsdl) + geom_point(aes(qqx, qqy)) + stat_smooth(aes(qqx, qqHat), method = "lm", 
    se = T, fill = "blue", alpha = 0.1) + facet_wrap(~name) + theme_ms(legend.position = "bottom")
```


**Plot of residuals against fitted value, to check variance relationship.**

```r
ggplot(aes(hat, residual), data = subset(rsdl, !is.na(hat) & !is.na(residual))) + 
    geom_hline(aes(yintercept = 0)) + geom_point() + stat_smooth(method = "loess", 
    span = 0.9, fill = "blue", alpha = 0.1) + facet_wrap(~name, scale = "free", 
    ncol = 3)
```


Profiles to check
----------------------------------------------------------------

```r
asp@control[, "val"] = asp@params[, 1]

prfl = rbind(cbind(Param = "K", profile(asp, which = "k", range = seq(0.8, 1.2, 
    length.out = 21))))
```



```r
ggplot(prfl) + geom_line(aes(k, rss))
```



Sensitivity Analysis
----------------------------------------------------------------

```r
albB0 = profile(asp, which = "b0", range = seq(0.8, 1.2, length.out = 21), fn = function(x) x)

plot(albB0, fn = list(Stock = function(x) stock(x)/bmsy(x), Harvest = function(x) harvest(x)/fmsy(x)))
```


Bootstrap
----------------------------------------------------------------

```r
albBoot = boot(asp)

plot(albBoot, fn = list(Stock = function(x) stock(x)/bmsy(x), Harvest = function(x) harvest(x)/fmsy(x))) + 
    geom_hline(aes(yintercept = 1), col = "red")
```



```r
library(kobe)
kobePhase(model.frame(mcf(FLQuants(stock = stock(albBoot)/bmsy(albBoot), harvest = harvest(albBoot)/fmsy(albBoot))))) + 
    geom_point(aes(stock, harvest))
```

