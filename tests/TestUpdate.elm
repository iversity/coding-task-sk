module TestUpdate exposing (testUpdate)

import Test exposing (Test,test,describe)
import Expect exposing (Expectation)

import Date

import Helpers.Stubs exposing (..)

import Model exposing (..)
import Msg exposing (Msg(..))
import Update exposing (update)


testUpdate : Test
testUpdate =
  describe "update"
    [ test "setCourses" <| \() -> testSetCourses
    , test "selectCourse" <| \() -> testSelectCourse
    , test "filterSetting defaults to current" <| \() -> testFilterSetting
    , test "setFilter" <| \() -> testSetFilter
    ]


stubCourses : List Course
stubCourses =
  [ stubCourse 1
  , stubCourse 2 ]


testFilterSetting : Expectation
testFilterSetting =
  initialModel.filterSetting
  |> Expect.equal Current


testSetFilter : Expectation
testSetFilter =
  let
      courses = stubCourses
      output = initialModel |> update (SetFilter Finished)
      (model', _) = output
  in
      model'.filterSetting
      |> Expect.equal Finished


testSetCourses : Expectation
testSetCourses =
  let
      courses = stubCourses
      output = initialModel |> update (SetCourses stubCourses)
      (model', _) = output
  in
      model'.courses
      |> Expect.equal stubCourses


testSelectCourse : Expectation
testSelectCourse =
  let
      id = 12345
      output = { initialModel | courses = stubCourses } |> update (SelectCourse id)
      (model', _) = output
  in
      model'.selectedCourseId
        |> Expect.equal (Just id)
