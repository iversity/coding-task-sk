module View exposing (view)

import Html exposing (Html,h1)
import Html.Attributes
import Html.Events

import Model exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view {text} =
  h1 [] [ Html.text text ]
