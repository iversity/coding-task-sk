module Helpers.Stubs exposing (..)

import Date exposing (Date)

import Model exposing (Course,Instructor)


stubCourse : Int -> Course
stubCourse index =
  { title = "Title"++(toString index)
  , subtitle = "Subtitle"++(toString index)
  , image = (toString index)++".png"
  , instructors = List.repeat index (Instructor "Instructor")
  , startDate = Date.fromTime (index |> toFloat)
  , endDate = Date.fromTime (index + 1 |> toFloat) }
