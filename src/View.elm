module View exposing (view)

import Html exposing (Html,div,h2)
import Html.Attributes
import Html.Events

import Model exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view {courses,currentDate} =
  courses
  |> currentCourses currentDate
  |> List.map renderItem
  |> div []


renderItem : Course -> Html Msg
renderItem course =
  h2 [] [ Html.text course.title ]
