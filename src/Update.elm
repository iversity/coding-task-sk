module Update exposing (..)

import Model exposing (..)

import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    SetCourses courses ->
      ({ model | courses = courses }, Cmd.none)
    SelectCourse id ->
      ({ model | selectedCourseId = Just id }, Cmd.none)
