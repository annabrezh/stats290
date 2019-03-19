## ------------------------------------------------------------------------
devtools::load_all()
library(annna)

## ------------------------------------------------------------------------
drugs_and_events <- queryAdverseEvents(limit = 100)
drugs_and_events

## ------------------------------------------------------------------------
queryRecalls(10)

## ---- eval=FALSE---------------------------------------------------------
#  drugs_and_events <- queryAdverseEvents(limit = 100)
#  plotDrugAdverseEvents(drugs_and_events, drug_of_interest = "LETAIRIS", variable_of_interest = "age")

## ---- out.width = "400px"------------------------------------------------
knitr::include_graphics("sample_plot.jpg")

## ---- eval=FALSE---------------------------------------------------------
#  plotTopTenDrugs(drugs_and_events)

## ---- out.width = "400px"------------------------------------------------
knitr::include_graphics("top_ten_drugs.jpg")

## ------------------------------------------------------------------------
drugs_and_events <- queryAdverseEvents(1000)
event_counts <- getEventCounts(drugs_and_events)
event_counts

## ---- eval=FALSE---------------------------------------------------------
#  plotEventCounts(drugs_and_events)

## ---- out.width = "400px"------------------------------------------------
knitr::include_graphics("time_series.jpg")

