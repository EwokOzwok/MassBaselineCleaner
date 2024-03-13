## code to prepare `CleanCols` dataset goes here
CleanCols<-read.csv("data-raw/CleanCols.csv", header = T, sep=",", encoding='UTF-8-ROM')
usethis::use_data(CleanCols, overwrite = TRUE)
