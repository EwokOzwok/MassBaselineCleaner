## code to prepare `Fall24_CleanCols` dataset goes here
Fall24CleanCols<-read.csv("data-raw/Fall24CleanCols.csv", header = T, sep=",", encoding='UTF-8-ROM')
usethis::use_data(Fall24CleanCols, overwrite = TRUE)
