
library(shiny)
library(leaflet)
library(sp)
library(raster)
library(rgdal)
library(mapview)
library(magrittr)
library(rsconnect)


server <- function(input, output) {
  output[["mymap"]] <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -2.0434570, lat = 54.681199, 
              zoom = 6) %>%
      addTiles(group = "OSM (default)") #%>%
    #addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery")
  })    
}