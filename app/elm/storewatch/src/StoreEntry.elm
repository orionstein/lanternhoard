port module StoreEntry exposing (..)

import StoreItem exposing (..)
import Json.Decode exposing (..)
import JsonHelper exposing (..)

decodeStoreEntry : Decoder StoreEntry
decodeStoreEntry =
  constructing StoreEntry
    `apply` ( "date" := Json.Decode.float )
    `apply` ( "items" := Json.Decode.list decodeStoreItem )
    `apply` ( Json.Decode.maybe <| "lastItem" := Json.Decode.bool )

type alias StoreEntry = {
  date: Float,
  items: List StoreItem,
  lastItem: Maybe Bool
}

