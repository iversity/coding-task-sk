module View.CourseDetailsPanel exposing (view)

import Html exposing (Html,div,p,h1,h2,h3,img,button)
import Html.Attributes exposing (class,classList,src,property)
import Html.Events

import Json.Encode

import Model exposing (..)
import View.Common exposing (..)
import Msg exposing (..)


view : Maybe Course -> Bool -> Html Msg
view selectedCourse active =
  let
      (content,backgroundUrl) =
        case selectedCourse of
          Nothing ->
            (div [] [] |> renderContent, "images/transparent.png")

          Just course ->
            (renderContainer course |> renderContent, course.image)
      classes =
        [ ("fullscreen-panel-wrapper", True)
        , ("course-details-panel", True)
        , ("active-panel", active) ]
      background =
        renderBackground backgroundUrl
  in
      div
        [ classList classes ]
        [ background, content ]


renderContent : Html Msg -> Html Msg
renderContent content =
  div
    [ class "fullscreen-panel-content" ]
    [ content ]


renderBackground : String -> Html Msg
renderBackground imageUrl =
  img
    [ src imageUrl
    , class "course-details-background" ]
    []


renderContainer : Course -> Html Msg
renderContainer course =
  let
      classes =
        [ ("container", True)
        , ("course-details-container", True) ]
  in
      div
        [ classList classes ]
        [ renderHeader course
        , renderEnrolButton
        , renderInstructors course
        , renderEnrolButton
        , renderBackButton ]


renderHeader : Course -> Html Msg
renderHeader course =
  div
    [ class "course-details-section" ]
    [ renderCourseTitle course
    , renderCourseSubtitle course ]


renderCourseTitle : Course -> Html Msg
renderCourseTitle {title} =
  h1
    []
    [ Html.text title ]


renderInstructors : Course -> Html Msg
renderInstructors {instructors} =
  let
      heading =
        h2
          []
          [ Html.text "Instructors" ]
      instructorProfiles = List.map renderInstructor instructors
      children = heading::instructorProfiles
  in
      div
        []
        children


renderInstructor : Instructor -> Html Msg
renderInstructor instructor =
  let
      name =
        h3
          []
          [ Html.text instructor.name ]
      images =
        case instructor.image of
          Nothing ->
            []

          Just url ->
            [ img
                [ src url ]
                []
            ]
      biography =
        p
          [ property "innerHTML" (Json.Encode.string instructor.biography) ]
          []
      children = [ name ] ++ images ++ [ biography ]
      classes =
        [ ("course-details-section", True)
        , ("course-details-instructor", True) ]
  in
      div
        [ classList classes ]
        children


renderEnrolButton : Html Msg
renderEnrolButton =
  let
      classes =
        [ ("filter-button", True)
        , ("selected", True) ]
      theButton =
        button
          [ classList classes ]
          [ Html.text "Sign up FREE" ]
  in
      div [ class "center-button-wrapper" ] [ theButton ]


renderBackButton : Html Msg
renderBackButton =
  div
    [ class "center-button-wrapper" ]
    [ button
      [ Html.Events.onClick NavigateToCatalogue
      , class "filter-button" ]
      [ Html.text "Back" ]
    ]
