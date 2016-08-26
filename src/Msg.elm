module Msg exposing (..)

import Http exposing (..)

import Model exposing (..)


type Msg
  = SetCourses (List Course)
  | SelectCourse Int
  | LoadFailure Http.Error


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
