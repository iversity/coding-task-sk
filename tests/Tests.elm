module Tests exposing (..)

import Test exposing (Test,test,describe)
import Expect


all : Test
all =
  describe "Main"
    [ test "dummy test" <|
      \() -> Expect.equal 5 5
    ]
