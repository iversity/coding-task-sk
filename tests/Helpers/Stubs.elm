module Helpers.Stubs exposing (..)

import Date exposing (Date)

import Model exposing (Course,Instructor)


stubCourse : Int -> Course
stubCourse index =
  { title = "Title"++(toString index)
  , subtitle = "Subtitle"++(toString index)
  , instructors = List.repeat index (Instructor "Instructor")
  , startDate = Date.fromTime (index |> toFloat)
  , endDate = Date.fromTime (index + 1 |> toFloat) }
