# Example of the WTSS package
#
# Retrieve an MOD13Q1 NDVI time series for a location in Brazilian Amazonia
# 
# Apply the Breakout Detection library from Twitter
#

# installing and loading packages
library(strucchange)
library(Rwtss)

# WTSS server URL
server <-  "https://brazildatacube.dpi.inpe.br/wtss/"

# get the list of coverages provided by the service
coverages <- Rwtss::list_coverages(server)

# get the description of the MOD13Q1 coverage
cv <-  Rwtss::describe_coverage(server, "MOD13Q1-6")

# get a time series for the "ndvi" attribute
# To create a token in BDC, please see: https://brazil-data-cube.github.io/applications/dc_explorer/token-module.html
ndvi <- Rwtss::time_series(
    URL = server, 
    name = "MOD13Q1-6", 
    attributes = "NDVI", 
    latitude = -10.408, 
    longitude = -53.495, 
    start_date = "2000-02-18", 
    end_date = "2016-01-01",
    token = "YOUR-BDC-TOKEN"
)

# plot the time series
plot(ndvi)

# transform time series to the TS format
ndvi_ts <- Rwtss::wtss_to_ts(ndvi)

# analysis using strucchange
fs.ndvi <- strucchange::Fstats(ndvi_ts ~ 1)

# plot the F statistics
plot(fs.ndvi)

# breakpoints
bk <- strucchange::breakpoints(fs.ndvi)

# plot breakpoints
lines(bk)

