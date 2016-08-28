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
    , test "setFilter" <| \() -> testSetFilter
    , describe "selecting a course" describeSelectCourse
    ]


stubCourses : List Course
stubCourses =
  [ stubCourse 1
  , stubCourse 2 ]


testSetFilter : Expectation
testSetFilter =
  let
      (model', _) =
        initialModel |> update (SetFilter Finished)
  in
      model'.filterSetting
      |> Expect.equal Finished


testSetCourses : Expectation
testSetCourses =
  let
      courses = stubCourses
      (model', _) =
        initialModel |> update (SetCourses stubCourses)
  in
      model'.courses
      |> Expect.equal stubCourses


describeSelectCourse : List Test
describeSelectCourse =
  [ test "SelectCourse sets a course" <| \() -> testSelectCourseSetsCourse
  , test "SelectCourse expands course details" <| \() -> testSelectCourseExpandsDetails
  , test "NavigateToCatalogue collapses course details" <| \() -> testNavigateToCatalogueCollapsesDetails
  ]


testSelectCourseSetsCourse : Expectation
testSelectCourseSetsCourse =
  let
      stub = stubCourse 1
      output = { initialModel | courses = stubCourses } |> update (SelectCourse stub)
      (model', _) = output
  in
      model'.selectedCourse
      |> Expect.equal (Just stub)


testSelectCourseExpandsDetails : Expectation
testSelectCourseExpandsDetails =
  let
      stub = stubCourse 1
      output = initialModel |> update (SelectCourse stub)
      (model', _) = output
  in
      model'.expandSelectedCourse
      |> Expect.equal True


testNavigateToCatalogueCollapsesDetails : Expectation
testNavigateToCatalogueCollapsesDetails =
  let
      output =
        { initialModel | expandSelectedCourse = True }
        |> update NavigateToCatalogue
      (model', _) = output
  in
      model'.expandSelectedCourse
      |> Expect.equal False
