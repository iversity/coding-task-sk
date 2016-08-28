module View exposing (view)

import Html exposing (Html,div)
import Html.Attributes exposing (class)

import Model exposing (..)
import View.CourseDetailsPanel
import View.CourseCataloguePanel
import Msg exposing (..)


view : Model -> Html Msg
view ({selectedCourse,expandSelectedCourse} as model) =
  div
    []
    [ View.CourseCataloguePanel.view model (not expandSelectedCourse)
    , View.CourseDetailsPanel.view selectedCourse expandSelectedCourse ]
