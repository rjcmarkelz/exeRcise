library(cycleRtools)
library(leaflet)
library(tidyverse)
library(RSQLite)
library(raster)
library(sp)

# data files
setwd("/Users/rjcmarkelz1/git.repos/exRcise/data/")
list.files()
dataFiles <- lapply(Sys.glob("Move*.fit"), read_fit)
names(dataFiles)
str(dataFiles)


cm_cycle <- read_fit("Move_2019_10_07_07_53_48_Cycling.fit")
cm_run <- read_fit("Move_2019_09_29_09_16_15_Trail_running.fit")
cm <- read_fit("Move_2019_09_22_08_14_59_Trail_running.fit")
Move_2019_09_22_08_14_59_Trail_running.fit
head(cm_cycle)
head(cm_run)
range(cm_run$lat)


head(cm)
tail(cm_cycle)
tail(cm_run)
ls()
names(cm)
names(cm_run)
names(cm_cycle


summary(cm)

leaflet(cm) %>% addTiles() %>% addPolylines(~lon, ~lat)
plot(cm, y = hr.bpm, xvar = "timer.min", xlim = c(0, 50))


plot(x = cm,     # "x" is the data, for consistency with other methods.
     y = 1:3,              # Which plots should be created? see below.
     xvar = "timer.min",   # What should be plotted on the x axis?
     xlab = "Time (min)",  # x axis label.
     laps = TRUE,          # Should different laps be coloured?
     breaks = TRUE)

plot(cm$hr.bpm)
plot(cm$lat, cm$long)

# sqlite
head(cm)
str(cm
cmdf <- as.data.frame(cm)
conn <- dbConnect(RSQLite::SQLite(), "cmFitnessDB.db")
dbWriteTable(conn, "TrailRun2", cmdf)
dbWriteTable(conn, "TrailRun1", as.data.frame(cm_run))
dbWriteTable(conn, "Cycle1", as.data.frame(cm_cycle))
dbListTables(conn)
dbGetQuery(conn, "SELECT * FROM TrailRun2")



# combine fitness and generic data
range(cm_run$lat) # [1] 37.98977 38.03973
range(cm_run$lon) # [1] -122.8278 -122.7966

name <- LETTERS[1:10]

lattest <- seq(37.98977, 38.03973, length.out = 10)
lontest <- seq(-122.8278, -122.7966, length.out = 10)


stations <- cbind(lontest, lattest)

cmpts <- cbind(cm_run$lon, cm_run$lat)
dim(cmpts)
# add some data to the plot
set.seed(10)
precip <- round((runif(length(lattest))*10)^3)

psize <- 1 + precip/500
plot(stations, cex=psize, pch=20, col='red', main="test-precipitation")
text(stations, name, pos=4)
lines(stations, lwd=3, pch=20)
points(cmpts)

?points()
stations
head(cmpts, 10)


pts <- SpatialPoints(cmpts)
class(pts)
showDefault(pts)

# to make the CRS arguments
crdref <- CRS('+proj=longlat +datum=WGS84')
pts <- SpatialPoints(cmpts, proj4string=crdref)


pts

# create a SpatialPointsDataFrame
precipvalue <- runif(nrow(cmpts), min=0, max=100)

df <- data.frame(ID=1:nrow(cmpts), precip=precipvalue)
df

lns <- spLines(cmpts, crs=crdref)
lns

pols <- spPolygons(cmpts, crs=crdref)
pols

plot(pols, axes=TRUE, las=1)
plot(pols, border='blue', col='yellow', lwd=3, add=TRUE)
points(pts, col='red', pch=20, cex=3)


# add multiple points
lon <- c(-116.8, -114.2, -112.9, -111.9, -114.2, -115.4, -117.7)
lat <- c(41.3, 42.9, 42.4, 39.8, 37.6, 38.3, 37.6)
x <- cbind(lon, lat)
plot(stations, main='precipitation')
polygon(x, col='blue', border='light blue')

points(x, cex=2, pch=20)
points(stations, cex=psize, pch=20, col='red', main="precipitation")

# combine geometry and attributes in a single data.frame
wst <- data.frame(longitude, latitude, name, precip)
wst

fitfileR for infiling data
if(!requireNamespace("remotes")) {
    install.packages("remotes")
}
remotes::install_github("grimbough/FITfileR")
library(FITfileR)

cmtest <- readFitFile("Move_2019_09_29_09_16_15_Trail_running.fit")
cmtest
cmtest_records <- records(cmtest)
cmtest_records
