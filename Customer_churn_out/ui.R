library(shinydashboard)
library(shinythemes)
library(shinyBS)
library(plotrix)
setwd("C:/Users/dharani.sugumar/Documents/Customer_churn_out/")
header<-dashboardHeader(title="Predictive Analysis Using Machine Learning" , titleWidth = 500 )
body<-
  dashboardBody(
    navbarPage("", id="nav",
               #creating a tab with the image on the right corner with text input and button click
               tabPanel("Customer Churn Out", width=500,div(img(src='syf.jpg',height = 80, width = 260, align = "right")),
                        div(class="outer",
                            fluidPage(theme = shinytheme("sandstone"),           
                                      fluidPage(textInput("CID",label = "CUSTOMER ID :","C0000010000")),
                                      basicPage(actionButton("button","Predict")))),
                        mainPanel(
                          verbatimTextOutput("value"),
                          div(tableOutput("churnpred"), style = "font-size: 100%; width: 75%"),
                          tags$style(type="text/css", "#patpred td:last-child {font-weight:bold;}"),
                          h3("Customer Churn out?"),
                          tableOutput("churnprob")
                        )
               )
    )
  )
dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)



