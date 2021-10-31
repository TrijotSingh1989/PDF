ui <- fluidPage(

  # App title ----
  titlePanel("Experience Based Pricing Tool"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput("file1", "Choose DHA Claims File",
                multiple = TRUE,
                accept = c("text/csv",
                         "text/comma-separated-values,text/plain",
                         ".pdf")),

      # Horizontal line ----
      tags$hr(),

      # Input: Checkbox if file has header ----
      #checkboxInput("header", "Header", TRUE),

      # Input: Select separator ----
      #radioButtons("sep", "Separator",
      #             choices = c(Comma = ",",
      #                         Semicolon = ";",
      #                         Tab = "\t"),
      #             selected = ","),

      # Input: Select quotes ----
      #radioButtons("quote", "Quote",
      #             choices = c(None = "",
      #                         "Double Quote" = '"',
      #                         "Single Quote" = "'"),
      #             selected = '"'),

      # Horizontal line ----
      tags$hr()

      # Input: Select number of rows to display ----
      #radioButtons("disp", "Display",
      #             choices = c(Head = "head",
      #                         All = "all"),
      #             selected = "head")

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Data file ----
     tabsetPanel(type = "tabs",
                 tabPanel("ClaimsInfo", tableOutput("contents")),
                 #tabPanel("CompletingClaimsinfo", mainPanel(rHandsontableOutput('contents3'))),
                 tabPanel("CompletingClaimsinfo", mainPanel('WIP')),
                 tabPanel("PremiumInfo", fluidPage(mainPanel(h2(textOutput("text_calc2")))),
                                                   numericInput("num", h3("Admin Charge (%)"), 
                                                             value = 10),
                                                   numericInput("num1", h3("Commission (%)"), 
                                                             value = 10),
                                                   numericInput("num2", h3("TLR (%)"), 
                                                                value = 95),
                                                  mainPanel(h2(textOutput("text_calc")),
                                                    h4(textOutput("text_calc3")))
                          )
                 ))
     #,
    #             tabPanel("WIP", tableOutput("contents")))
     # tableOutput("contents"))

    )

  )

