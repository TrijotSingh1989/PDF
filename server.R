library(pdftools)
library(dplyr)
library(tidyverse)
library(stringi)
# Define server logic to read selected file ----
server <- function(input, output) {

  output$contents <- renderTable({

    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.

    req(input$file1)

    data1 <- pdf_text(input$file1$datapath)%>%
      readr::read_lines()
    #  str_squish() %>%
    #  str_replace_all(",","") %>%
    #  strsplit(split=" ") %>%
    #unlist()
month <- 0
year <- 0
Claim_Value <- 0
for(i in 1:12) {
  # i-th element of `u1` squared into `i`-th position of `usq`

  test19<- data1[i+94] %>%
  str_squish() %>%
  str_replace_all(",","") %>%
  strsplit(split=" ")
  test20 <- test19[1] %>%
    unlist()
  month[i] <- test20[2]
  year[i] <- test20[4]
  Claim_Value[i] <- as.numeric(test20[5])

}
 Client_name_deri <- data1[3]%>%
  str_squish() %>%
  str_replace_all(",","") %>%
  strsplit(split=" ")

ClientName_deri1 <-Client_name_deri %>%
  unlist()

ClientName <- c(ClientName_deri1[5],ClientName_deri1[6])
ClientName <- paste0(ClientName_deri1[5],ClientName_deri1[6], collapse = NULL)

client.data <- data.frame(ClientName, year, month,Claim_Value)

    #df1 <- c(data1[2],data1[2])
   #df1 <- c(data1[13384],data1[13564],data1[13546])
    df1 <- data.frame(ClientName,month,year,Claim_Value)
   return(df1)

  })

}

