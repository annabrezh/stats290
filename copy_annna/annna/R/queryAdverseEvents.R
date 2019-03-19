#' Allow users to query Open FDA Drug Adverse Events
#'
#' @description Allow users to query for a given number of result objects that represent
#' a set of Open FDA Drug Adverse Events. The example function returns a tidy dataframe
#' with drugs and events.
#' @export
#' @import httr
#' @import jsonlite
#' @import tidyr
#' @import tibble
#' @import dplyr
#'
#' @param limit the number of adverse events to return
#' @param date_start the date for which you want the adverse events to start in format YYYYMMDD
#' @param date_end the date for which you want the adverse events to stop in format YYYYMMDD
#' Both date_start and date_end must be supplied if one is supplied, but both are optional.
#' @return a dataframe with drug and adverse information for the number of results
#' Columns include: id, sex, age, drug, drug indication, date and reaction.
#'
#' @examples
#' queryAdverseEvents(limit = 101)
#' queryAdverseEvents(limit=10, date_start="20050101", date_end="20060101")
#'

# write a function that will loop through the requested number of results
# TODO: Add ability to query by in between dates
# main function of interest
queryAdverseEvents <- function(limit=1, date_start = NULL, date_end = NULL) {

    total_adverse_events = 9487279
    if(limit > total_adverse_events) {
        limit = total_adverse_events
    }

    limit_allowed_by_fda = 100
    drugs <- tibble()
    adverse_events <- tibble()

    # say limit is 101
    skip = 0
    while (limit > limit_allowed_by_fda) {
        df <- queryOpenFDA(limit_allowed_by_fda, skip, event_or_enforcement = "event",
                           date_start = date_start, date_end = date_end)
        if(is.null(df)) {
            print("no matches found for parameters specified")
            return()
        }
        drugs_and_events <- getDrugsAndEvents(df)
        drugs <- rbind(drugs, drugs_and_events$drugs)
        adverse_events <- rbind(adverse_events, drugs_and_events$adverse_events)

        limit <- limit - limit_allowed_by_fda
        skip <- skip + limit_allowed_by_fda

    }

    df <- queryOpenFDA(limit, skip, event_or_enforcement = "event",
                       date_start = date_start, date_end = date_end)
    if(is.null(df)) {
        print("no matches found for parameters specified")
        return()
    }
    drugs_and_events <- getDrugsAndEvents(df)
    drugs <- rbind(drugs, drugs_and_events$drugs)
    adverse_events <- rbind(adverse_events, drugs_and_events$adverse_events)
    drugs_and_events <- inner_join(drugs, adverse_events)

    drugs_and_events

}


getAges <- function(patient_info) {
    patient_ages <- lapply(patient_info, function(x) {x$patientonsetage})
    patient_ages <- lapply(patient_ages, function(x) {
        if(is.null(x)) {
            "unknown"
        }
        else {
            x
        }
    })
    patient_ages
}


getSex <- function(patient_info) {
    patient_sex <- lapply(patient_info, function(x) {x$patientsex})
    patient_sex <- lapply(patient_sex, function(x) {
        if(is.null(x)) {
            "unknown"
        }
        else {
            x
        }
    })
    patient_sex
}


getReactions <- function(patient_info) {
    patient_reactions <- lapply(patient_info, function(x) {x$reaction})
    patient_reactions <- lapply(patient_reactions, function(x){
        lapply(x, function(y) {
            y$reactionmeddrapt
        })
    })
    patient_reactions
}


getDrugs <- function(patient_info) {
    patient_drugs <- lapply(patient_info, function(x) {x$drug})

    patient_drugs <- lapply(patient_drugs, function(x) {
        lapply(x, function(y) {
            y$medicinalproduct })})
    patient_drugs
}


getDrugIndication <- function(patient_info) {
    patient_drugs <- lapply(patient_info, function(x) {x$drug})

    patient_drug_indication <- lapply(patient_drugs, function(x) {
        lapply(x, function(y) {
            y$drugindication })})

    patient_drug_indication <- lapply(patient_drug_indication, function(x) {
        lapply(x, function(y) {
            if(is.null(y)) {
                "unknown"
            }
            else {
                y
            }
        })
    })

    patient_drug_indication
}


getDrugsAndEvents <- function(df) {
    results <- df$results
    ids <- lapply(results, function(x){x$safetyreportid})
    date <- lapply(results, function(x) {x$receivedate})
    patient_info <- lapply(results, function(x) {x$patient})
    patient_ages <- getAges(patient_info)
    patient_sexes <- getSex(patient_info)
    patient_reactions <- getReactions(patient_info)
    patient_drugs <- getDrugs(patient_info)
    patient_drug_indications <- getDrugIndication(patient_info)


    adverse_events <- tibble(id = unlist(ids), sex = unlist(patient_sexes), age = unlist(patient_ages), reaction = patient_reactions, date = unlist(date))
    adverse_events <- adverse_events %>% unnest() %>% unnest()
    adverse_events[["date"]] <- as.Date(adverse_events[["date"]], "%Y%m%d")


    drugs <- tibble(id = unlist(ids), sex = unlist(patient_sexes), age = unlist(patient_ages), drug = patient_drugs, drug_indication = patient_drug_indications)
    drugs <- drugs %>% unnest() %>% unnest()

    return(list("adverse_events" = adverse_events, "drugs" = drugs))
}





