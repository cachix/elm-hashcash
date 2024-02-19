module Tests.HashCash exposing (..)


import Test exposing (Test)
import HashCash
import Expect


suite : Test
suite = Test.describe "findNonce"
    [ Test.test "with difficulty 3" (\() -> HashCash.findNonce 3 "abc" |> Expect.equal 93803)
    , Test.test "with difficulty 1" (\() -> HashCash.findNonce 1 "abc" |> Expect.equal 252)
    , Test.test "with difficulty 2" (\() -> HashCash.findNonce 2 "abc" |> Expect.equal 1322)
    ]