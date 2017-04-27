extract <- function(geotype) {
  Data <- lapply(2009:2016, function(year){
    download.file(paste0("https://www.huduser.gov/portal/datasets/pictures/files/county", "_", year, ".xlsx"), "temp.xlsx")
    read_excel("temp.xlsx") %>%
      mutate(year = year,
             geotype = "countyfp",
             entities = as.character(entities),
             states = as.character(states),
             latitude = as.character(latitude),
             longitude = as.character(longitude),
             pha_total_units = as.character(pha_total_units),
             ha_size = as.numeric(ha_size)) %>%
      rename(geoid = code)
  }) %>%
    bind_rows()

  unlink("temp.xlsx")
  return(Data)
}
