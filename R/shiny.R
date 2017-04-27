data <- function(input, output, session){
  progress <- shiny::Progress$new()
  on.exit(progress$close())
  progress$set(message = "Loading data...")

  # Edit the data function here
  # Data <- readRDS("Data.rda")

  Data <- hud::extract() %>%
    filter(program == 1 & rent_per_month > 0) %>%
    select(geotype, geoid, year, rent_per_month) %>%
    filter(year == 2015)

  counties(cb = TRUE, resolution = '20m') %>%
    geo_join(Data, 'GEOID', 'geoid')
}

content <- function(input, output, session){

  renderLeaflet({
    Data <- callModule(hud::data, 'content')

    progress <- shiny::Progress$new()
    on.exit(progress$close())
    progress$set(message = "Building map...")

    pal <- colorNumeric("Greens", Data$rent_per_month)

    leaflet(Data) %>%
      addTiles() %>%
      addPolygons(fillColor = ~pal(rent_per_month),
                  color = "white",
                  fillOpacity = 0.5,
                  weight = 0.5)
  })
}
