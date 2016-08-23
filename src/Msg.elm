module Msg exposing (..)

import Model exposing (..)


type Msg
  = NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
  [] |> Sub.batch
