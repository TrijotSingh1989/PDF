# Title     : TODO
# Objective : TODO
# Created by: TJIpadAccess
# Created on: 06/11/20

library(pdftools)
library(dplyr)
#setting the path where the PDF Files are saved
file_vector <- list.files(path = getwd())
file_vector %>% head()
grepl(".pdf",file_vector)
pdf_list <- file_vector[grepl(".pdf",file_vector)]

#Axa Claims report for FlyDubai for testing purpose
pdf_list[2]
test <- pdf_text(pdf_list[2]) %>%
  readr::read_lines()
