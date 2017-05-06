# This is the user-interface scriptn of your Shiny web application. 
# Find out more about building applications with Shiny here:
#    http://shiny.rstudio.com/
#

# Create a dashboard page

dashboardPage(
  
  dashboardHeader(title = "Term Project"),
   dashboardSidebar(),
  dashboardBody(

# Create text panel
  fluidRow(
        box(
      # width = 4, 
      background = "olive",
      "CS695 - Group 1"
    )
  ),
  
# Create word cloud panel with three boxes, one for input and one for output and one for discussion 
  fluidRow(
    
    box(
      width = 8,
      title = "Word cloud of DeSales",     
      plotOutput("distPlot1")
    
    ),
    box(
      width =4,
      #background = "aqua",
      title = "Select number of words to show on the graph ",
      sliderInput("bins",
                  "Number of words:",
                  min = 1,
                  max = 75,
                  value = 40)
      
    ),
    
    box(
       width = 4, 
      background = "olive",
      "Wrod cloud is an image composed of words used n a particcular text, subject or dataset. here the size of each word indicates the its frequency.Here DeSalesMedia is used most number of times. Poeple have also mentioned BrooklynDiocese,NETnyTV and WCDnyc. "
    )
 
     ),

# Create sentiment analysis panel with two boxes, one for input and one for output and one for discussion    
  fluidRow(
    
    box(
      width = 8, 
     title = "Sentiment analysis of DeSales",     
      plotOutput("distPlot2")
      
    ) ,
    box(
      width = 4, 
      title = "Select number of words to show on the graph ",
      sliderInput("bins2",
                  "Number of words:",
                  min = 1,
                  max = 20,
                  value = 10)
      
    
    ),
    box(
      width = 4, 
      background = "olive",
      "Sentiment analysis is sthe method of identifying and categorizing the opinions expressed in a particular daataset. it may be towrds a particular topic, product, person, etc. it may be positive, negative or neutral.Maximum numberr of people have remain neutral while talking about DeSales. while considerable amount of people have taalked positive in a manner of one or two words."
    )
  ), 

# Create network graph panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
      title = "Network Graph of DeSales",     
   plotOutput("distPlot3")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "Network graph shows the relationship between people, group or organization. the nodes are the people or groups and the limks are the relations. here the graph for DeSales is shown very clumpsy/compact because numerous people are connected to desales. but more number of people are connected with the main branch of DeSales."
  )
  ), 

# Create customer profile panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
    title = "user profile of DeSales",     
    plotOutput("distPlot4")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "User profile shows the personal informaation of every user profile. this helps in analysing the type of audience connecting eith the organization or group.Here it is clearly seen that maximum people connected with the DeSales are male and less number of female users are connected."
  )
  
), 

# Create topic analysis panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
    title = "topic analysis of DeSales",     
    plotOutput("distPlot5")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "Topic analysis divides the larger topic in to smaller parts and gets the audience to better understanding.Here the tweets mwntioning about the sports category are 48%, where as not mentioning sports are 52%, ehich shows the interst of consumers in sports."
  )
  ) 


)

)

