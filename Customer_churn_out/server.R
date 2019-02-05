library(shiny)
library(dplyr)
#setting up work directory
setwd("C:\\Users\\dharani.sugumar\\Documents\\Customer_churn_out")
#reading dataset without customer id
newdataset<-read.csv("Churnout_Customer_wo_cid.csv", header=TRUE  )
#reading the all required fields
dsets<-read.csv("Churnout_Customer.csv", header=TRUE  )
#Extracting columns whichever required
dsetsdata = dsets[c("Customer_ID","Customer_Name","Customer_Age","Customer_Location","Customer_Income_Group","Customer_Activity","Customer_Segment")]; 
#Reading customer id
cusid<-read.csv("cusid.csv", header=TRUE  )
#Extracting columns required for the dataset without customer id
#newdata = newdataset[c("Customer_Name", "Customer_Phone_Number","Customer_Age","Customer_Location","Customer_Income_Group","Customer_Login_Details","Customer_Activity","Customer_Segment")]; 
#converting to dataframe 
tbframe<-as.data.frame(newdataset)
library(rpart)
#loading classification tree 
treeH<-rpart(Customer_churn_out~.,data=tbframe,method="class")
#Building model based on target variable
Customer_Churn_Out<-predict(treeH,tbframe,type="class")
#predicting the outcome
New_Data=cbind(cusid,newdataset,Customer_Churn_Out )
#binding all the companies
pred_data<-write.csv(New_Data,"Pred.csv",row.names = FALSE)
#writing the result to csv file
preds<-read.csv("Pred.csv", header=TRUE  )
predss = preds[c("Customer_ID","Customer_Churn_Out")]; 
#prediction result
#*****************************************************

shinyServer(function(input, output) {
  
  #creating a reactive event for button click
  rand<-eventReactive(input$button,dsetsdata)
  #showing it in the render table
  output$churnpred<-renderTable({
    df<-subset(rand(), Customer_ID == input$CID)})
  
  output$churnprob<-renderTable ({
    dfss<-subset(predss,Customer_ID == input$CID)%>%
      distinct})
  #selecting distinct records
  
  
  
  
})
