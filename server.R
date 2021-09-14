library(pdftools)
library(dplyr)
library(tidyverse)
library(stringi)
library(tidyr)
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
day <- 0
#data1 = str_squish(data1)
#data1 = str_replace_all(data1,",","")
#data1 = strsplit(data1,split=" ")
#data1 = unlist(data1)
#seperate(data1)
#x <- paste(data1, collapse = "")
y = unlist(strsplit(data1, split = " "))
k = stri_remove_empty(y, na_empty = FALSE)
str_locate(k, '17a')
t = unlist(gregexpr("17a", k))
which(t == "True")
datanumber = which(t > 0)
datanumber = datanumber-1

for(i in 1:12) {
  # i-th element of `u1` squared into `i`-th position of `usq`
  month[i] <- k[datanumber+(5*i-3)]
  day[i] <- k[datanumber+(5*i-2)]
  year[i] <- k[datanumber+(5*i-1)]
  cl <- k[datanumber+5*i]
  cl1 <- str_split(cl, "\n")
  cl2 <- unlist(cl1)
  cl3 <- cl2[1]
  Claim_Value[i] <- as.numeric(gsub(",","",cl3))
}

t1 = unlist(gregexpr("Policy", k))
which(t1 == "True")
datanumber1 = which(t1 > 0)
datanumber1 = datanumber1-2
k[datanumber1][1]

t2 = unlist(gregexpr("Name", k))
which(t2 == "True")
datanumber2 = which(t2 > 0)
datanumber2 = datanumber2+3
k[datanumber2][1]
ClientName <- ''
seq(datanumber2[1], datanumber1[1])
numberchar_clientName = datanumber1[1]-datanumber2[1]
for(i in datanumber2[1]:datanumber1[1]) {
  ClientName1 <- (k[i])
  ClientName <- c(ClientName,paste(ClientName1, collapse = "," ))
}
ClientName_used1 = str_c(ClientName,collapse=',') 
ClientName_used2 = str_c(ClientName_used1,collapse=',')
ClientName_used3 = str_replace_all(ClientName_used2,",","")
client.data <- data.frame(ClientName_used3, year, month,Claim_Value)
    #df1 <- c(data1[2],data1[2])
   #df1 <- c(data1[13384],data1[13564],data1[13546])
    df1 <- data.frame(ClientName_used3,month,year,Claim_Value)
   return(df1)

  })

  output$contents1 <- renderTable({
    
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
    day <- 0
    #data1 = str_squish(data1)
    #data1 = str_replace_all(data1,",","")
    #data1 = strsplit(data1,split=" ")
    #data1 = unlist(data1)
    #seperate(data1)
    #x <- paste(data1, collapse = "")
    y = unlist(strsplit(data1, split = " "))
    k = stri_remove_empty(y, na_empty = FALSE)
    str_locate(k, '17a')
    t = unlist(gregexpr("17a", k))
    which(t == "True")
    datanumber = which(t > 0)
    datanumber = datanumber-1
    
    for(i in 1:12) {
      # i-th element of `u1` squared into `i`-th position of `usq`
      month[i] <- k[datanumber+(5*i-3)]
      day[i] <- k[datanumber+(5*i-2)]
      year[i] <- k[datanumber+(5*i-1)]
      cl <- k[datanumber+5*i]
      cl1 <- str_split(cl, "\n")
      cl2 <- unlist(cl1)
      cl3 <- cl2[1]
      Claim_Value[i] <- as.numeric(gsub(",","",cl3))
    }
    
    t1 = unlist(gregexpr("Policy", k))
    which(t1 == "True")
    datanumber1 = which(t1 > 0)
    datanumber1 = datanumber1-2
    k[datanumber1][1]
    
    t2 = unlist(gregexpr("Name", k))
    which(t2 == "True")
    datanumber2 = which(t2 > 0)
    datanumber2 = datanumber2+3
    k[datanumber2][1]
    ClientName <- ''
    seq(datanumber2[1], datanumber1[1])
    numberchar_clientName = datanumber1[1]-datanumber2[1]
    for(i in datanumber2[1]:datanumber1[1]) {
      ClientName1 <- (k[i])
      ClientName <- c(ClientName,paste(ClientName1, collapse = "," ))
    }
    ClientName_used1 = str_c(ClientName,collapse=',') 
    ClientName_used2 = str_c(ClientName_used1,collapse=',')
    ClientName_used3 = str_replace_all(ClientName_used2,",","")
    client.data <- data.frame(ClientName_used3, year, month,Claim_Value)
    #df1 <- c(data1[2],data1[2])
    #df1 <- c(data1[13384],data1[13564],data1[13546])
    df1 <- data.frame(ClientName_used3,month,year,Claim_Value)
    #return(df1)
    Total_Claims = sum(df1$Claim_Value)
    Total_premium = Total_Claims * 1.10
    Total_Claims = formatC(Total_Claims, format="f", big.mark=",", digits=1)
    Total_premium = formatC(Total_premium, format="f", big.mark=",", digits=1)
    df2 <- data.frame(Total_Claims,Total_premium)
    return(df2)
  })  
  
  
}




