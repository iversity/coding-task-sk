module TestModel exposing (testModel)

import Test exposing (Test,test,describe)
import Expect

import Model exposing (initialModel)


testModel : Test
testModel =
  describe "Model"
    [ test "starts with an empty list of courses" <|
      \() ->
        initialModel.courses |> Expect.equal []
    ]
