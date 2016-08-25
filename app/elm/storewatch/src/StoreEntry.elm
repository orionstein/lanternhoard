port module StoreEntry exposing (..)

import StoreItem exposing (..)
import Json.Decode exposing (..)
import JsonHelper exposing (..)

decodeStoreEntry : Decoder StoreEntry
decodeStoreEntry =
  constructing StoreEntry
    `apply` ( "date" := Json.Decode.float )
    `apply` ( "items" := Json.Decode.list decodeStoreItem )

type alias StoreEntry = {
  date: Float,
  items: List StoreItem
}

