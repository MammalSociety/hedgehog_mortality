library(shiny)
library(leaflet)
library(sp)
library(raster)
library(rgdal)
library(mapview)
library(magrittr)
library(rsconnect)



server <- function(input, output) {
  
  
  r <- raster("_Hogs__log_allps.tif")

  p<-raster("Reclass_bin")
  
  crs(r) <- sp::CRS('+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs')
  
  crs(p) <- sp::CRS('+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs')
  
  papl<-colorNumeric(c( "#FF0000"), values(p),
                     na.color = "transparent")
  #pal <- colorNumeric(c("#FF0000"), values(r),
  #  na.color = "transparent")
  pal <- colorNumeric(c("#0C2C84","#FFFFCC", "#FF3333" ), values(r), #dark blue, yellow, red
                      na.color = "transparent")
  
  
  
  output[["mymap"]] <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -2.0434570, lat = 54.681199, 
              zoom = 6) %>%
      addTiles(group = "OSM (default)") %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
      #addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") 
      
      addRasterImage(r, colors = pal, opacity = 0.8, maxBytes = 30 * 1024 * 1024, group="Hedgehog Roadkill Probability")    %>%
      addLegend("bottomleft",pal = pal, values = values(r),
                title = "Roadkill Probability") %>%
      #addMiniMap()%>%
      
      addRasterImage(p, colors = papl, opacity = 0.8, maxBytes = 30 * 1024 * 1024,group="High Probability of Roadkill Occurence") %>%
      addMiniMap()%>%
      
      # Layers control
      addLayersControl(
        baseGroups = c("OSM (default)", "Esri World Imagery"),
        overlayGroups = c( "Hedgehog Roadkill Probability","High Probability of Roadkill Occurence"),
        options = layersControlOptions(collapsed = FALSE)
      )
    
  })    
}