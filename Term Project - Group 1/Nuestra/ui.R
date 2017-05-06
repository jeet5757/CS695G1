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
      title = "Word cloud of Nuestra",     
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
      "Wrod cloud is an image composed of words used n a particcular text, subject or dataset. here the size of each word indicates the its frequency.NuestraVozDOB is occurred mostly in the tweets. People have alos mentioned PopInUSA, Pontifex number of times than ay other words. "
    )
 
     ),

# Create sentiment analysis panel with two boxes, one for input and one for output and one for discussion    
  fluidRow(
    
    box(
      width = 8, 
     title = "Sentiment analysis of Nuestra",     
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
      "Sentiment analysis is sthe method of identifying and categorizing the opinions expressed in a particular daataset. it may be towrds a particular topic, product, person, etc. it may be positive, negative or neutral.Almost majority of people have talked neutral about Nuestra. Few people have have talked positive about it in one or two words."
    )
  ), 

# Create network graph panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
      title = "Network Graph of Nuestra",     
   plotOutput("distPlot3")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "Network graph shows the relationship between people, group or organization. the nodes are the people or groups and the limks are the relations.Lots of users are connecting with Nuestra so it is very messy and hard to read. the users connecting with the company are more in number and they are making the graph look very full."
  )
  ), 

# Create customer profile panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
    title = "user profile of Nuestra",     
    plotOutput("distPlot4")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "User profile shows the personal informaation of every user profile. this helps in analysing the type of audience connecting with the organization or group.The number of male users talking are more than the femalaes. but it is seen that most of the consumers while talking about Nuestra are the unknown gender."
  )
  
), 

# Create topic analysis panel with two boxes, one for output and one for discussion    
fluidRow(
  
  box(
    width = 8, 
    title = "topic analysis of Nuestra",     
    plotOutput("distPlot5")
    
  ) ,
  box(
    width = 4, 
    background = "olive",
    "Topic analysis divides the larger topic in to smaller parts and gets the audience to better understanding.The audience talking about sports is clearly less than it was in DeSales, it is only 24% here. While the audience not talking about sports is 76%."
  )
  ) 


)

)

