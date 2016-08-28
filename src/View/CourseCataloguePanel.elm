module View.CourseCataloguePanel exposing (view)

import Html exposing (Html,div,p,h1,h2,h3,img)
import Html.Attributes exposing (class,classList)
import Html.Events

import String

import Model exposing (..)
import View.Common exposing (..)
import Msg exposing (..)


view : Model -> Bool -> Html Msg
view model active =
  let
      classes =
        [ ("fullscreen-panel-wrapper", True)
        , ("course-catalogue-panel", True)
        , ("active-panel", active) ]
  in
      div
        [ classList classes ]
        [ renderContent model ]


renderContent : Model -> Html Msg
renderContent model =
  div
    [ class "fullscreen-panel-content" ]
    [ renderHeader model
    , renderListOfCourses model ]


renderHeader : Model -> Html Msg
renderHeader model =
  div
    [ class "course-catalogue-header" ]
    [ renderHeading
    , renderSubheading
    , renderFilter model ]


renderHeading : Html Msg
renderHeading =
  h1
    []
    [ Html.text "Enrol now!" ]


renderSubheading : Html Msg
renderSubheading =
  h2
    []
    [ Html.text "All our courses are free to try" ]


renderListOfCourses : Model -> Html Msg
renderListOfCourses {courses,currentDate,filterSetting} =
  courses
  |> filterByDate filterSetting currentDate
  |> orderByDate
  |> List.map renderCourseItem
  |> div []


renderCourseItem : Course -> Html Msg
renderCourseItem course =
  let
      classes = [ ("course-item", True) ]
  in
      div
        [ classList classes
        , Html.Events.onClick (SelectCourse course) ]
        [ renderCourseImage course
        , renderCourseTint
        , renderCourseBody course ]


renderCourseTitle : Course -> Html Msg
renderCourseTitle {title} =
  h2
    []
    [ Html.text title ]


renderCourseImage : Course -> Html Msg
renderCourseImage {image} =
  img
    [ Html.Attributes.src image ]
    []


renderCourseTint : Html Msg
renderCourseTint =
  div
    [ class "course-tint" ]
    []


renderCourseBody : Course -> Html Msg
renderCourseBody course =
  let
      classes = [ ("course-body", True) ]
  in
      div
        [ classList classes ]
        [ renderCourseTitle course
        , renderCourseInstructors course
        , renderCourseSubtitle course
        , renderCourseStartDate course ]


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
        [ renderFilterButton "Finished" Finished filterSetting
        , renderFilterButton "Running" Current filterSetting
        , renderFilterButton "Upcoming" Upcoming filterSetting ]
      classes = [ ("course-filters", True) ]
  in
      Html.div
        [ classList classes ]
        options


renderFilterButton : String -> FilterSetting -> FilterSetting -> Html Msg
renderFilterButton name targetSetting chosenSetting =
  let
      classes =
        [ ("filter-button", True)
        , ("selected", targetSetting==chosenSetting) ]
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
