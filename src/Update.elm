module Update exposing (..)

import Task
import Date

import Model exposing (..)
import Msg exposing (..)
import Load exposing (loadCourses)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    SetCourses courses ->
      ({ model | courses = courses }, Cmd.none)
    SelectCourse id ->
      ({ model | selectedCourseId = Just id }, Cmd.none)
    LoadFailure error ->
      (model, loadCourses) -- just keep trying forever
    SetDateAndThenLoadCourses date ->
      ({ model | currentDate = date }, loadCourses)
    NoOp ->
      (model, Cmd.none)


refreshCatalogue : Cmd Msg
refreshCatalogue =
  Date.now |> Task.perform (\_ -> NoOp) SetDateAndThenLoadCourses
