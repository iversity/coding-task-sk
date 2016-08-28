module View.Common exposing (..)

import Html exposing (Html,h2,h3)

import Model exposing (..)
import Msg exposing (..)


renderCourseSubtitle : Course -> Html Msg
renderCourseSubtitle {subtitle} =
  h3
    []
    [ Html.text subtitle ]
