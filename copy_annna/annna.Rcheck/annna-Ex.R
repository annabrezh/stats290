pkgname <- "annna"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "annna-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('annna')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("getEventCounts")
### * getEventCounts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: getEventCounts
### Title: Allow users to analyze Open FDA Drug Adverse Events
### Aliases: getEventCounts

### ** Examples

drugs_and_events <- queryAdverseEvents(limit=10)
getEventCounts(drugs_and_events)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("getEventCounts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotDrugAdverseEvents")
### * plotDrugAdverseEvents

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotDrugAdverseEvents
### Title: Allow users to visualize drug information against selected
###   variable.
### Aliases: plotDrugAdverseEvents

### ** Examples

drugs_and_events <- queryAdverseEvents(limit = 101)
plotDrugAdverseEvents(drugs_and_events, "LETAIRIS", "age")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotDrugAdverseEvents", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotEventCounts")
### * plotEventCounts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotEventCounts
### Title: Allow users to analyze Open FDA Drug Adverse Events data over
###   time.
### Aliases: plotEventCounts

### ** Examples

drugs_and_events <- queryAdverseEvents(limit=10)
plotEventCounts(drugs_and_events)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotEventCounts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotTopTenDrugs")
### * plotTopTenDrugs

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotTopTenDrugs
### Title: Allow users to analyze Open FDA Drug Adverse Events data over
###   time.
### Aliases: plotTopTenDrugs

### ** Examples

drugs_and_events <- queryAdverseEvents(limit=10)
plotTopTenDrugs(drugs_and_events)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotTopTenDrugs", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("queryAdverseEvents")
### * queryAdverseEvents

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: queryAdverseEvents
### Title: Allow users to query Open FDA Drug Adverse Events
### Aliases: queryAdverseEvents

### ** Examples

queryAdverseEvents(limit = 101)
queryAdverseEvents(limit=10, date_start="20050101", date_end="20060101")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("queryAdverseEvents", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("queryOpenFDA")
### * queryOpenFDA

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: queryOpenFDA
### Title: Allow users to query Open FDA Drug Adverse Events
### Aliases: queryOpenFDA

### ** Examples

queryOpenFDA(limit = 1, skip = 0, event_or_enforcement = "enforcement")
queryOpenFDA(date_start = "20040101", date_end = "20131231")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("queryOpenFDA", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("queryRecalls")
### * queryRecalls

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: queryRecalls
### Title: Allow users to query Open FDA Drug Recall Information
### Aliases: queryRecalls

### ** Examples

queryRecalls(limit = 10)
queryRecalls(limit=10, date_start="20050101", date_end="20060101")




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("queryRecalls", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
