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
    String.padLeft (difficulty + 1) '0' hash == String.repeat (difficulty + 1) "0"

{-| Given the difficulty level, data, and a starting nonce, it searches for a nonce that makes the hash meet the criteria.

Example:
    ```
    findNonce 3 "example data" 0
    ```
    This will search for a nonce that, when combined with the data, produces a hash that starts with 4 leading zeros.
-}
findNonce : Int -> String -> Nonce -> Nonce
findNonce difficulty data nonce =
    let
        candidate = generateCandidate data nonce
        hashResult = sha256 candidate
    in
    if meetsCriteria difficulty hashResult then
        nonce
    else
        findNonce difficulty data (nonce + 1)
