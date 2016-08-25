module TestUpdate exposing (testUpdate)

import Test exposing (Test,test,describe)
import Expect

import Date

import Helpers.Stubs exposing (..)

import Model exposing (Model,Course,initialModel)
import Msg exposing (Msg(..))
import Update exposing (update)


testUpdate : Test
testUpdate =
  describe "update"
    [ test "replaces the list of courses" <|
      \() ->
        initialModel
        |> update (SetCourses stubCourses)
        |> Expect.equal ({ courses = stubCourses }, Cmd.none)
    ]


stubCourses : List Course
stubCourses =
  [ stubCourse 1
  , stubCourse 2 ]
