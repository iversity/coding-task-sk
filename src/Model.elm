module Model exposing (..)

import Date exposing (Date)


type alias Model =
  { courses : List Course
  , currentDate : Date
  , selectedCourseId : Maybe Int
  , filterSetting : FilterSetting }

type alias Course =
  { title : String
  , startDate : Date
  , endDate : Date }

type FilterSetting
  = Current
  | Finished
  | Upcoming


initialModel : Model
initialModel =
  { courses = []
  , currentDate = Date.fromTime 0
  , selectedCourseId = Nothing
  , filterSetting = Current }


orderByDate : List Course -> List Course
orderByDate courses =
  courses
  |> List.sortBy (\course -> course.startDate |> Date.toTime)


filterByDate : FilterSetting -> Date -> List Course -> List Course
filterByDate setting currentDate courses =
  let
      fn = case setting of
        Upcoming ->
          (\course ->
            Date.toTime course.startDate > Date.toTime currentDate)

        Finished ->
          (\course ->
            Date.toTime course.endDate < Date.toTime currentDate)

        Current ->
          (\course ->
            (Date.toTime course.startDate <= Date.toTime currentDate) &&
            (Date.toTime course.endDate >= Date.toTime currentDate))
  in
      courses
      |> List.filter fn
