port module JsonHelper exposing (..)

import Json.Decode exposing (..)

-- Applicative's `pure`:
constructing : a -> Json.Decode.Decoder a
constructing = Json.Decode.succeed

-- Applicative's `<*>`:
apply : Json.Decode.Decoder (a -> b) -> Json.Decode.Decoder a -> Json.Decode.Decoder b
apply = Json.Decode.object2 (<|)
