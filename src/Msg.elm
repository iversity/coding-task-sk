module Msg exposing (..)

import Http exposing (..)
import Date exposing (Date)

import Model exposing (..)


type Msg
  = SetCourses (List Course)
  | SelectCourse Course
  | NavigateToCatalogue
  | LoadFailure Http.Error
  | SetDate Date
  | SetFilter FilterSetting
  | NoOp


type Page
  = Home
  | Details


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
