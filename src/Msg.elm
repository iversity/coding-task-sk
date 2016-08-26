module Msg exposing (..)

import Http exposing (..)
import Date exposing (Date)

import Model exposing (..)


type Msg
  = SetCourses (List Course)
  | SelectCourse Int
  | LoadFailure Http.Error
  | SetDate Date
  | SetFilter FilterSetting
  | NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
