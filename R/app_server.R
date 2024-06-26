#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @import haven
#' @import shinyjs
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  options(shiny.maxRequestSize=50*1024^2)
  data_Mass <- reactive(input$MassBaseline$datapath[[1]])


  observeEvent(input$MassBaseline$datapath,{
    output$clean<-renderUI({
      tagList(
        f7Button("cleanbutton", "Clean Data", active=T)
      )
    })

  })

  # df<-read_sav("MassSurvey_Baseline+Spring+2024_June+25,+2024_20.55.sav")


  clean_data<-function(inputdata){
    data<-inputdata
    data<-as.matrix(as.data.frame(data))
    data<-data[,-c(1:4,6:7,8:18,598)]
    # colnames(data)<-CleanCols[,1]
    data<-as.data.frame(data)


    dich_cols<-c(5:13, 15:31, 33, 39:47 ,61:69, 404:449)

    for(i in dich_cols){
      for(j in 1:nrow(data)){
        data[j,i]<-ifelse(is.na(data[j,i])==T,0,data[j,i])
      }
    }
    return(data)
  }


  observeEvent(input$cleanbutton,{
    output$clean<-renderUI({})
    data<-haven::read_sav(data_Mass())
    data<-clean_data(inputdata=data)

          output$status<-renderUI({
            tagList(
              f7Align(h4("Data Cleaned & Download Ready!"),side=c("center"))
            )
          })

          output$clean<-renderUI({
            tagList(
              f7DownloadButton("downloadbutton", "Download Clean Data (.csv)")
            )
          })

          output$downloadbutton = downloadHandler(
            filename = function() {
              paste("Mass_Baseline_Clean - ", Sys.Date(), ".csv", sep="")
              },
            content = function(file) {
              write.csv(data, file)
            }
          )

  })

  # observeEvent(input$cleanbutton,{
  #   data<-haven::read_sav(data_Mass())
  #   data<-as.matrix(as.data.frame(data))
  #   data<-data[,-c(1:4,6:7,9:18,598:600)]
  #   colnames(data)<-CleanCols[,1]
  #   data<-as.data.frame(data)
  #   data<-clean_data(inputdata=data)
  #   output$pleasewait<-renderUI({})
  #
  #   output$clean<-renderUI({
  #     tagList(
  #     f7DownloadButton("downloadbutton", "Download Clean Data (.csv)")
  #     )
  #   })
  #
  #   output$downloadbutton = downloadHandler(
  #     filename = function() {
  #       paste("Mass_Baseline_Clean - ", Sys.Date(), ".csv", sep="")
  #     },
  #     content = function(file) {
  #       write.csv(data, file)
  #     }
  #   )
  #
  #
  # })










}



