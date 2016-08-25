port module StoreItemDiff exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Encode exposing (..)

type alias StoreItemDiff = {
  title: String,
  price: Float,
  link: Maybe String,
  status: String,
  priceChange: Float
}

storeItemDiffView : (Json.Encode.Value -> a) -> StoreItemDiff -> Html a
storeItemDiffView act item =
  tr [ class <| "storeItem " ++ item.status ] [
    case item.status of
        "Lost" ->
          td [ class "itemStatus" ] [ i [ class "zmdi zmdi-minus" ] [] ]
        "New" ->
          td [ class "itemStatus" ] [ i [ class "zmdi zmdi-plus" ] [] ]
        "Price" ->
          td [ class "itemStatus" ] [ text "~" ]
        _ ->
          td [ class "itemStatus" ] [ text " " ]
  , case item.link of
      Just link ->
        td [ class "itemName" ] [
          a [ href <| "https://shop.kingdomdeath.com" ++ link, target "_blank" ] [
            text item.title
          ]
        ]
      Nothing ->
        td [ class "itemName" ] [ text item.title ]
  , td [ class "itemPrice" ] [ text <| "$" ++ toString item.price ]
  , if ( item.status == "Price" ) then 
      td [ class "itemPriceDelta" ] [ 
        span [ 
          class "tooltip maintenanceTooltip"
         , if ( item.priceChange < 0 ) then 
           Html.Attributes.attribute "data-text" ("Price Decreased by $" ++ (toString <| abs item.priceChange)) else
           Html.Attributes.attribute "data-text" ("Price Increased by $" ++ (toString <| abs item.priceChange)) 
        ] [ 
          span [ 
            classList [
                ("color--alizarin", item.priceChange > 0)
              , ("color--nephritis", item.priceChange < 0) ] 
          ] [ 
            i [ if (item.priceChange < 0) then class "zmdi zmdi-triangle-down" else class "zmdi zmdi-triangle-up" ] []
          , span [] [ text <| " $" ++ (toString <| abs item.priceChange) ]
          ]
        ]
      ]
    else
      td [ class "itemPriceDelta" ] [ text " " ]
  ]

