module Update exposing (..)

import Date
import Task

import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    SetCourses courses ->
      ({ model | courses = courses }, Cmd.none)

    SelectCourse course ->
      ({ model | selectedCourse = Just course
               , expandSelectedCourse = True }, Cmd.none)

    NavigateToCatalogue ->
      ({ model | expandSelectedCourse = False }, Cmd.none)

    SetDate date ->
      ({ model | currentDate = date }, Cmd.none)

    SetFilter setting ->
      ({ model | filterSetting = setting }, Cmd.none)

    LoadFailure _ -> -- out of scope for now: handle HttpError
      (model, Cmd.none)

    NoOp ->
      (model, Cmd.none)


refreshCurrentDate : Cmd Msg
refreshCurrentDate =
  Date.now |> Task.perform (\date -> NoOp) SetDate
