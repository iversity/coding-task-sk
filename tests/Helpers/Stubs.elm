module Helpers.Stubs exposing (..)

import Date exposing (Date)

import Model exposing (Course)


stubCourse : Int -> Course
stubCourse index =
  { title = "Title"++(toString index)
  , startDate = Date.fromTime (toFloat index) }