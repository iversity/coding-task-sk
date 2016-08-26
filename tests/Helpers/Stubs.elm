module Helpers.Stubs exposing (..)

import Date exposing (Date)

import Model exposing (Course)


stubCourse : Int -> Course
stubCourse index =
  { title = "Title"++(toString index)
  , subtitle = "Subtitle"++(toString index)
  , startDate = Date.fromTime (index |> toFloat)
  , endDate = Date.fromTime (index + 1 |> toFloat) }
