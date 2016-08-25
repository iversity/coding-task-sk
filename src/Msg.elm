module Msg exposing (..)

import Model exposing (..)


type Msg
  = SetCourses (List Course)
  | SelectCourse Int


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
