module Msg exposing (..)

import Model exposing (..)


type Msg
  = SetCourses (List Course)


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
