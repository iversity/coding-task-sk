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
    [ test "starts with an empty list of courses" <|
      \() ->
        initialModel.courses |> Expect.equal []
    , describe "orderByDate" testOrderByDate
    , describe "upcomingCourses" testUpcomingCourses
    , describe "finishedCourses" testFinishedCourses
    ]


testUpcomingCourses : List Test
testUpcomingCourses =
  [ test "empty list" <|
    \() ->
      []
      |> upcomingCourses (Date.fromTime 0)
      |> Expect.equal []
  , test "0 of 1" <|
    \() ->
      [ stub1 ]
      |> upcomingCourses (Date.fromTime 1)
      |> Expect.equal []
  , test "1 of 1" <|
    \() ->
      [ stub1 ]
      |> upcomingCourses (Date.fromTime 0)
      |> Expect.equal [ stub1 ]
  , test "0 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> upcomingCourses (Date.fromTime 2)
      |> Expect.equal []
  , test "1 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> upcomingCourses (Date.fromTime 1)
      |> Expect.equal [ stub2 ]
  , test "2 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> upcomingCourses (Date.fromTime 0)
      |> Expect.equal [ stub1, stub2 ]
  ]


testFinishedCourses : List Test
testFinishedCourses =
  [ test "empty list" <|
    \() ->
      []
      |> finishedCourses (Date.fromTime 0)
      |> Expect.equal []
  , test "0 of 1" <|
    \() ->
      [ stub1 ]
      |> finishedCourses (Date.fromTime 0)
      |> Expect.equal []
  , test "1 of 1" <|
    \() ->
      [ stub1 ]
      |> finishedCourses (Date.fromTime 3)
      |> Expect.equal [ stub1 ]
  , test "0 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> finishedCourses (Date.fromTime 2)
      |> Expect.equal []
  , test "1 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> finishedCourses (Date.fromTime 3)
      |> Expect.equal [ stub1 ]
  , test "2 of 2" <|
    \() ->
      [ stub1, stub2 ]
      |> finishedCourses (Date.fromTime 4)
      |> Expect.equal [ stub1, stub2 ]
  ]


testOrderByDate : List Test
testOrderByDate =
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
