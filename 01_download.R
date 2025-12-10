# 01_download.R
library(readr)

url <- "https://data.cityofchicago.org/resource/7as2-ds3y.csv"

download.file(url, destfile = "data/potholes_raw.csv", mode = "wb")

raw <- read_csv("data/potholes_raw.csv")
print(paste("download succeeful total", nrow(raw), "lines of data"))
