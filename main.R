#######################################################################################
# EXAMPLES:
#-> Returns title and author from documents with the keyword  "slicing"
#g21ieee_data[grepl("Slicing", g21ieee_data$Author.Keywords, ignore.case=T, fixed=T), c(1,2)]

#-> Returns title and author from documents with DOI: 10.23919/ITU-WT.2018.8597639
#g21ieee_data[grepl("10.23919/ITU-WT.2018.8597639", g21ieee_data$DOI, fixed=T), c(1,2)]
#######################################################################################

require("dplyr")
source("utils.R")

core_g2ieee <- read.table("data/IEEE/G2_core_documents", sep="|", head=T, stringsAsFactors=F)

data_g21ieee <- read.csv("data/IEEE/G21_IEEE_2021.09.14-18.19.19.csv", head=T, stringsAsFactors=F)
data_g22ieee <- read.csv("data/IEEE/G22_IEEE_2021.09.17-01.42.49.csv", head=T, stringsAsFactors=F)
data_g23ieee <- read.csv("data/IEEE/G23_IEEE_2021.09.17-02.11.15.csv", head=T, stringsAsFactors=F)
data_g24ieee <- read.csv("data/IEEE/G24_IEEE_2021.09.23-21.21.21.csv", head=T, stringsAsFactors=F)
#data_g25ieee <- read.csv("data/IEEE/G25_IEEE_2021.09.23-20.39.33.csv", head=T, stringsAsFactors=F)

score_g21ieee <- score_fn(data_g21ieee, core_g2ieee)
excluded_g21ieee <- filter(core_g2ieee, !(doi %in% data_g21ieee$DOI))

score_g22ieee <- score_fn(data_g22ieee, core_g2ieee)
excluded_g22ieee <- filter(core_g2ieee, !(doi %in% data_g22ieee$DOI))

score_g23ieee <- score_fn(data_g23ieee, core_g2ieee)
excluded_g23ieee <- filter(core_g2ieee, !(doi %in% data_g23ieee$DOI))

score_g24ieee <- score_fn(data_g24ieee, core_g2ieee)
excluded_g24ieee <- filter(core_g2ieee, !(doi %in% data_g24ieee$DOI))

#score_g25ieee <- score_fn(data_g25ieee, core_g2ieee)
#excluded_g25ieee <- filter(core_g2ieee, !(doi %in% data_g25ieee$DOI))
#######################################################################################

string_compare <- data.frame(
  string = c("G21", "G22", "G23", "G24"),
  score = c(score_g21ieee, score_g22ieee, score_g23ieee, score_g24ieee),
  results = c(nrow(data_g21ieee)-1, nrow(data_g22ieee)-1, nrow(data_g23ieee)-1, nrow(data_g24ieee)-1)
)

string_compare

#write.csv(subset(data_g24ieee, select= -c(Author.Affiliations, Abstract, Date.Added.To.Xplore, Funding.Information)), "G24_IEEE_CUSTOM.csv", row.names=F)
