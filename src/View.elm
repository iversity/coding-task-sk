module View exposing (view)

import Html exposing (Html,div,h2)
import Html.Attributes
import Html.Events

import Model exposing (..)

import Msg exposing (..)


view : Model -> Html Msg
view model =
  div
    []
    [ renderFilter model
    , renderCourses model ]


renderCourses : Model -> Html Msg
renderCourses {courses,currentDate,filterSetting} =
  let
      filterFn = case filterSetting of
        Current -> currentCourses
        Finished -> finishedCourses
        Upcoming -> upcomingCourses
  in
      courses
      |> filterFn currentDate
      |> List.map renderCourse
      |> div []


renderCourse : Course -> Html Msg
renderCourse course =
  h2 [] [ Html.text course.title ]


renderFilter : Model -> Html Msg
renderFilter {filterSetting} =
  let
      options =
        [ renderButton "Finished" Finished filterSetting
        , renderButton "Current" Current filterSetting
        , renderButton "Upcoming" Upcoming filterSetting ]
  in
      Html.div
        [ Html.Attributes.class "course-filters" ]
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
        , Html.Attributes.classList classes
        , Html.Events.onClick (SetFilter targetSetting) ]
        [ Html.text name ]
