module Update exposing (..)

import Date
import Task
import Navigation
import Dom.Scroll

import Model exposing (..)
import Msg exposing (..)
import Load exposing (loadCourses)

import Debug exposing (log)


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

    DomNodeNotFound error ->
      let
          debugMessage = error |> log "DomNodeNotFound"
      in
          (model, Cmd.none)

    DomScroll () ->
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
      ({ model | expandSelectedCourse = True }, scrollDetailsToTop)


refreshCurrentDate : Cmd Msg
refreshCurrentDate =
  Date.now |> Task.perform (\date -> NoOp) SetDate


scrollDetailsToTop : Cmd Msg
scrollDetailsToTop =
  Dom.Scroll.toTop "details-panel-content"
  |> Task.perform DomNodeNotFound DomScroll
