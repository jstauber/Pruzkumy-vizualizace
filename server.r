library(shiny)
library(dplyr)
library(ggvis)

predvolebni_pruzkumy <- read.csv("predvolebni_pruzkumy.csv")
predvolebni_pruzkumy <- as.data.frame(predvolebni_pruzkumy)
predvolebni_pruzkumy$value <- as.numeric(predvolebni_pruzkumy$value)
predvolebni_pruzkumy$end_date <- as.character(predvolebni_pruzkumy$end_date)
predvolebni_pruzkumy$end_date <- as.Date(predvolebni_pruzkumy$end_date, "%Y-%m-%d")
predvolebni_pruzkumy$choice_id <- as.factor(predvolebni_pruzkumy$choice_id)
predvolebni_pruzkumy$pollster_id <- as.factor(predvolebni_pruzkumy$pollster_id)
predvolebni_pruzkumy$question_identifier <- as.factor(predvolebni_pruzkumy$question_identifier)

shinyServer(function(input, output) {
    predvolebni_pruzkumy %>%
      ggvis(~ end_date, ~ value, stroke = ~factor(choice_id)) %>%
      filter(pollster_id %in% eval(input_select(c("cvvm", "median")))) %>%
      filter(question_identifier %in% eval(input_select(c("model", "preference", "sympatie")))) %>%
      filter(choice_id %in% eval(input_checkboxgroup(c("kdu-csl", "kscm", "cssd", "ods", "zeleni", "usvit", "top-09", "ano", "vv")))) %>%
      layer_lines(strokeWidth := 3) %>%
      layer_points(fill := "white") %>%
      bind_shiny("plot1", "p_ui")
  })
