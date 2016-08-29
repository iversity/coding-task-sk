module CourseCatalogue exposing (..)

import Html exposing (Html)

import Navigation

import Model exposing (Model,initialModel)
import Update exposing (update,urlUpdate,refreshCurrentDate)
import View exposing (view)
import Msg exposing (Msg,Page(..),subscriptions)


main : Program Never
main =
  Navigation.program urlParser
    { init = init
    , update = update
    , urlUpdate = urlUpdate
    , view = view
    , subscriptions = subscriptions }


init : Page -> (Model, Cmd Msg)
init _ =
  urlUpdate Home initialModel


urlParser : Navigation.Parser Page
urlParser =
  Navigation.makeParser fromUrl


fromUrl : Navigation.Location -> Page
fromUrl location =
  if location.pathname == "/details" then
    Details
  else
    Home
