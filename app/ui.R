
library(shiny)
library(leaflet)
library(sp)
library(raster)
library(rgdal)
library(mapview)
library(magrittr)
library(rsconnect)

ui <- fluidPage(
  title = "Interactive Map",
  leafletOutput("mymap", width = "100%", height = "700px")
)