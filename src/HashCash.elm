module HashCash exposing (findNonce)

{-| This module provides functions for generating and validating HashCash values.

# Types

@docs Nonce

# Functions

@docs findNonce

-}

import Sha256 exposing (sha256)

type alias Nonce = Int

generateCandidate : String -> Nonce -> String
generateCandidate data nonce =
    data ++ (String.fromInt nonce)

meetsCriteria : Int -> String -> Bool
meetsCriteria difficulty hash =
    String.startsWith (String.repeat (difficulty + 1) "0") hash

{-| Given the difficulty level and data it searches for a nonce that makes the hash meet the criteria.

Example:

    ```
    findNonce 3 "example data"
    ```

This will search for a nonce that, when combined with the data, produces a hash that starts with 4 leading zeros.
-}
findNonce : Int -> String -> Nonce
findNonce difficulty data =
    let
        go nonce =
            if meetsCriteria difficulty (sha256 (generateCandidate data nonce)) then
                nonce
            else
                go (nonce + 1)
    in go 0
   
