![Elm package](https://img.shields.io/elm-package/v/cachix/elm-hashcash)

Implements [HashCash](https://en.wikipedia.org/wiki/Hashcash) in Elm to
prevent spammers abusing a resource.

HashCash hashes your data with a `sha256` and appends a nonce.

It then verifies that the hash has N number of leading zeros, which is the difficulty level.

If it doesn't match, it increases the nonce by 1 and retries.

The more leading zeros you want, the longer it takes to find the hash.

Here's an example how to calculate the nonce and send it over with the data:

```elm
import HashCash

let 
  data = "example data"
  difficulty = 3
  nonce = HashCash.findNonce difficulty data
in { nonce = nonce 
   , data = data
   }
```

### Development

[Install devenv](https://devenv.sh/getting-started/) and `devenv shell elm-test`.