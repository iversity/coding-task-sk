module View exposing (view)

import Html exposing (Html,div,p,h1,h2,h3)
import Html.Attributes exposing (class,classList)
import Html.Events

import String

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
        [ renderCourseTitle course
        , renderCourseInstructors course
        , renderCourseSubtitle course ]


renderCourseTitle : Course -> Html Msg
renderCourseTitle {title} =
  h2
    []
    [ Html.text title ]


renderCourseSubtitle : Course -> Html Msg
renderCourseSubtitle {subtitle} =
  h3
    []
    [ Html.text subtitle ]


renderCourseInstructors : Course -> Html Msg
renderCourseInstructors {instructors} =
  let
      names = List.map .name instructors
      text = joinNames names
  in
      p
        [ class "instructor" ]
        [ Html.text text ]


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


joinNames : List String -> String
joinNames names =
  case names of
    [] ->
      ""

    [ name ] ->
      name

    [ first, second ] ->
      first ++ " & " ++ second

    hd::tl ->
      hd ++ ", " ++ (joinNames tl)
