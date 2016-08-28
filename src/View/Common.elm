module View.Common exposing (..)

import Html exposing (Html,h2,h3)

import Date

import Model exposing (..)
import Msg exposing (..)


renderCourseSubtitle : Course -> Html Msg
renderCourseSubtitle {subtitle} =
  h3
    []
    [ Html.text subtitle ]


renderCourseStartDate : Course -> Html Msg
renderCourseStartDate {startDate} =
  let
      text =
        "Start "
        ++ (Date.day startDate |> toString)
        ++ " "
        ++ (Date.month startDate |> toString)
        ++ " "
        ++ (Date.year startDate |> toString)
  in
      h3
        []
        [ Html.text text ]
