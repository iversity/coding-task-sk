module TestModel exposing (testModel)

import Test exposing (Test,test,describe)
import Expect

import Date exposing (Date)

import Helpers.Stubs exposing (..)

import Model exposing (Course,initialModel,orderByDate)


(stub1, stub2, stub3)  = (stubCourse 1, stubCourse 2, stubCourse 3)


testModel : Test
testModel =
  describe "Model"
    [ test "starts with an empty list of courses" <|
      \() ->
        initialModel.courses |> Expect.equal []
    , describe "orderByDate" testOrderByDate
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
