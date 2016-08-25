module Model exposing (..)

import Date exposing (Date)


type alias Model =
  { courses : List Course }

type alias Course =
  { title : String
  , startDate : Date }


initialModel : Model
initialModel =
  { courses = [] }


orderByDate : List Course -> List Course
orderByDate courses =
  courses
  |> List.sortBy (\course -> course.startDate |> Date.toTime)


upcomingCourses : Date -> List Course -> List Course
upcomingCourses currentDate courses =
  courses
  |> List.filter
       (\course ->
         Date.toTime course.startDate > Date.toTime currentDate)
