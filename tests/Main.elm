port module Main exposing (..)

import Test exposing (Test,describe)
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)

import TestModel exposing (testModel)


main : Program Value
main =
  run emit completeSuite


completeSuite : Test
completeSuite =
  describe "CourseCatalogue"
    [ testModel ]


port emit : ( String, Value ) -> Cmd msg
