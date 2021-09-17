require("dplyr")

score_fn <- function(data, core_df){
  score <- (nrow(filter(data, DOI %in% core_df$doi)) / nrow(core_df)) * 100
  score
}
