module TestModel exposing (testModel)

import Test exposing (Test,test,describe)
import Expect

import Date exposing (Date)

import Helpers.Stubs exposing (..)

import Model exposing (..)


(stub1, stub2, stub3)  = (stubCourse 1, stubCourse 2, stubCourse 3)


testModel : Test
testModel =
  describe "Model"
    [ describe "initialModel" describeDefaultValues
    , describe "orderByDate" describeOrderByDate
    , describe "filterByDate Upcoming" describeUpcomingCourses
    , describe "filterByDate Finished" describeFinishedCourses
    , describe "filterByDate Current" describeCurrentCourses
    ]


describeUpcomingCourses : List Test
describeUpcomingCourses =
  [ test "empty list" <|
    \() ->
      []
      |> filterByDate Upcoming (Date.fromTime 0)
      |> Expect.equal []
  , test "0 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Upcoming (Date.fromTime 1)
      |> Expect.equal []
  , test "1 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Upcoming (Date.fromTime 0)
      |> Expect.equal [ stub1 ]
  , test "0 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Upcoming (Date.fromTime 2)
      |> Expect.equal []
  , test "1 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Upcoming (Date.fromTime 1)
      |> Expect.equal [ stub2 ]
  , test "2 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Upcoming (Date.fromTime 0)
      |> Expect.equal [ stub1, stub2 ]
  ]


describeFinishedCourses : List Test
describeFinishedCourses =
  [ test "empty list" <|
    \() ->
      []
      |> filterByDate Finished (Date.fromTime 0)
      |> Expect.equal []
  , test "0 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Finished (Date.fromTime 0)
      |> Expect.equal []
  , test "1 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Finished (Date.fromTime 3)
      |> Expect.equal [ stub1 ]
  , test "0 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Finished (Date.fromTime 2)
      |> Expect.equal []
  , test "1 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Finished (Date.fromTime 3)
      |> Expect.equal [ stub1 ]
  , test "2 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Finished (Date.fromTime 4)
      |> Expect.equal [ stub1, stub2 ]
  ]


describeCurrentCourses : List Test
describeCurrentCourses =
  [ test "empty list" <|
    \() ->
      []
      |> filterByDate Current (Date.fromTime 0)
      |> Expect.equal []
  , test "0 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Current (Date.fromTime 0)
      |> Expect.equal []
  , test "1 of 1" <|
    \() ->
      [ stub1 ]
      |> filterByDate Current (Date.fromTime 1)
      |> Expect.equal [ stub1 ]
  , test "0 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Current (Date.fromTime 4)
      |> Expect.equal []
  , test "1 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Current (Date.fromTime 3)
      |> Expect.equal [ stub2 ]
  , test "2 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> filterByDate Current (Date.fromTime 2)
      |> Expect.equal [ stub1, stub2 ]
  ]


describeOrderByDate : List Test
describeOrderByDate =
  [ test "empty list" <|
    \() ->
      []
      |> orderByDate
      |> Expect.equal []
  , test "list with 1 element" <|
    \() ->
      [ stub1 ]
      |> orderByDate
      |> Expect.equal [ stub1 ]
  , test "list with 2 elements, ordered" <|
    \() ->
      [ stub1, stub2 ]
      |> orderByDate
      |> Expect.equal [ stub1, stub2 ]
  , test "list with 2 elements, unordered" <|
    \() ->
      [ stub2, stub1 ]
      |> orderByDate
      |> Expect.equal [ stub1, stub2 ]
  , test "list with 3 elements, ordered" <|
    \() ->
      [ stub1, stub2, stub3 ]
      |> orderByDate
      |> Expect.equal [ stub1, stub2, stub3 ]
  , test "list with 3 elements, unordered" <|
    \() ->
      [ stub3, stub1, stub2 ]
      |> orderByDate
      |> Expect.equal [ stub1, stub2, stub3 ]
  ]


describeDefaultValues : List Test
describeDefaultValues =
  [ test "no courses loaded" <|
    \() ->
      initialModel.courses |> Expect.equal []

  , test "filter courses to show current ones only" <|
    \() ->
      initialModel.filterSetting |> Expect.equal Current

  , test "no course selected" <|
    \() ->
      initialModel.selectedCourse |> Expect.equal Nothing

  , test "course details are hidden" <|
    \() ->
      initialModel.expandSelectedCourse |> Expect.equal False
  ]
