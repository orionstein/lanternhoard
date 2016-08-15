port module StoreItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode exposing (..)
import Json.Decode exposing (..)
import JsonHelper exposing (..)

decodeStoreItem : Decoder StoreItem
decodeStoreItem =
  constructing StoreItem
    `apply` ("title" := Json.Decode.string)
    `apply` ("price" := Json.Decode.string)
    `apply` (Json.Decode.maybe <| "link" := Json.Decode.string)

type alias StoreItem = {
  title: String,
  price: String,
  link: Maybe String
}

storeItemView : (Json.Encode.Value -> a) -> StoreItem -> Html a
storeItemView act item =
  tr [ class "storeItem" ] [
    case item.link of
      Just link ->
        td [ class "itemName" ] [
          a [ href <| "https://shop.kingdomdeath.com" ++ link, target "_blank" ] [
            text item.title
          ]
        ]
      Nothing ->
        td [ class "itemName" ] [ text item.title ]
    , td [ class "itemPrice" ] [ text item.price ]
  ]
