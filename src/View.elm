module View exposing (view)

import Html exposing (Html,div,h2)
import Html.Attributes exposing (class,classList)
import Html.Events

import Model exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ renderFilter model
    , renderCourses model ]


renderCourses : Model -> Html Msg
renderCourses {courses,currentDate,filterSetting} =
  courses
  |> filterByDate filterSetting currentDate
  |> List.map renderCourse
  |> div []


renderCourse : Course -> Html Msg
renderCourse course =
  let
      classes = [ ("course-item", True)
                , ("gray-bg", True) ]
  in
      div
        [ classList classes ]
        [ renderCourseTitle course ]


renderCourseTitle : Course -> Html Msg
renderCourseTitle {title} =
  h2
    []
    [ Html.text title ]


renderFilter : Model -> Html Msg
renderFilter {filterSetting} =
  let
      options =
        [ renderButton "Finished" Finished filterSetting
        , renderButton "Current" Current filterSetting
        , renderButton "Upcoming" Upcoming filterSetting ]
      classes = [ ("course-filters", True) ]
  in
      Html.div
        [ classList classes ]
        options


renderButton : String -> FilterSetting -> FilterSetting -> Html Msg
renderButton name targetSetting chosenSetting =
  let
      classes =
            [ ("flatbutton", True)
            , ("selected", targetSetting==chosenSetting)
            ]
  in
      Html.button
        [ Html.Attributes.type' "radio"
        , Html.Attributes.name "dateFilter"
        , classList classes
        , Html.Events.onClick (SetFilter targetSetting) ]
        [ Html.text name ]
