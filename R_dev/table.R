
library(cli)
library(magrittr)
library(colorDF)


show_files <- function(df) {

  theme <- colorDF::get_colorDF_theme("universal")
  theme$interleave <- NULL
  theme$col.names$bg <- "white"
  theme$col.names$fg <- "black"
  colorDF::add_colorDF_theme(theme, "pipeline", "pipeline")

  df %<>%
    mutate(
    filename = ifelse(found, crayon::green(filename), crayon::red(filename))
  )
  colorDF::colorDF(df, theme="pipeline")
}


df <- data.frame(
  found = c(T,F,F),
  changed = c(T,T,F),
  filename = c("EIS Liste (POV ohne Filter)", "Projekte (Hiry Liste)", "Datamapping III")
)


cli({
  cli_h1("HLN Pipeline")
  cli_alert_success("Found config file:  xxxxxxx")
  cli_alert_success("Updated database.")
})

show_files(df)


