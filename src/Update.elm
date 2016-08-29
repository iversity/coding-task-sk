module Update exposing (..)

import Date
import Task
import Navigation

import Model exposing (..)
import Msg exposing (..)
import Load exposing (loadCourses)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    SetCourses courses ->
      ({ model | courses = courses }, Cmd.none)

    SelectCourse course ->
      ({ model | selectedCourse = Just course
               , expandSelectedCourse = True }, Navigation.newUrl "/details")

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


urlUpdate : Page -> Model -> (Model, Cmd Msg)
urlUpdate page model =
  case page of
    Home ->
          ({ model | expandSelectedCourse = False }
          , Cmd.batch [ refreshCurrentDate , loadCourses ])

    Details ->
      ({ model | expandSelectedCourse = True }, Cmd.none)


refreshCurrentDate : Cmd Msg
refreshCurrentDate =
  Date.now |> Task.perform (\date -> NoOp) SetDate
