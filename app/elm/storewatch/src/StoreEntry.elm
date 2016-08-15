port module StoreEntry exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (..)
import Date.Extra.Config.Config_en_us exposing (config)
import Date.Extra.Format as Format exposing (format)
import StoreItem exposing (..)
import StoreItemDiff exposing (..)
import Json.Encode exposing (..)
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

