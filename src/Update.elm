module Update exposing (..)

import Model exposing (..)

import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    NoOp ->
      (model, Cmd.none)