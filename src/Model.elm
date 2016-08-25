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
  List.sortBy (\course -> course.startDate |> Date.toTime) courses
