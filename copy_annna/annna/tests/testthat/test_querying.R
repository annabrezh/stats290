context("Test querying adverse events")
library(dplyr)

test_that("adverse events returns a dataframe", {
    df <- queryAdverseEvents(limit = 1)
    expect_is(df, "data.frame")
})

context("Test querying recalls")
test_that("query recall returns a dataframe", {
    df <- queryRecalls(limit = 1)
    expect_is(df, "data.frame")
})

context("Test using open fda api returns a result list")
test_that("open fda returns a dataframe", {
    df <- queryOpenFDA()
    expect_is(df, "list")
})

context("Test getting number of events")
test_that("getEventCounts returns correct number of events", {
    test_limit <- 10
    drugs_and_events <- queryAdverseEvents(limit=test_limit)
    df <- getEventCounts(drugs_and_events)
    expect_equal(test_limit, sum(df$unique_date_events))
})
