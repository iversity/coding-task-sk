module Model exposing (..)

import Date exposing (Date)


type alias Model =
  { courses : List Course }

type alias Course =
  { title : String
  , startDate : Date
  , endDate : Date }


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


finishedCourses : Date -> List Course -> List Course
finishedCourses currentDate courses =
  courses
  |> List.filter
       (\course ->
         Date.toTime course.endDate < Date.toTime currentDate)


currentCourses : Date -> List Course -> List Course
currentCourses currentDate courses =
  courses
  |> List.filter
       (\course ->
         (Date.toTime course.startDate <= Date.toTime currentDate) &&
         (Date.toTime course.endDate >= Date.toTime currentDate))
