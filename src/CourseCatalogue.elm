module CourseCatalogue exposing (..)

import Html exposing (Html)
import Html.App as Html

import Model exposing (Model,initialModel)
import Update exposing (update,refreshCurrentDate)
import View exposing (view)
import Msg exposing (subscriptions)
import Load exposing (loadCourses)


main : Program Never
main =
  Html.program
  { init = (initialModel, Cmd.batch [refreshCurrentDate, loadCourses])
  , update = update
  , view = view
  , subscriptions = subscriptions }
