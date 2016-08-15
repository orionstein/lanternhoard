port module StoreEntryDiff exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Date exposing (..)
import Date.Extra.Config.Config_en_us exposing (config)
import Date.Extra.Format as Format exposing (format)
import StoreEntry exposing (..)
import Set exposing (..)
import String exposing (..)
import Dict exposing (..)
import List exposing (..)
import StoreItem exposing (..)
import StoreItemDiff exposing (..)
import Json.Encode exposing (..)
import Json.Decode exposing (..)
import JsonHelper exposing (..)

diffAllEntries : List StoreEntry -> List StoreEntryDiff
diffAllEntries entries =
  List.foldr (\a b -> (getEntryDiff a (List.head b |> Maybe.withDefault (StoreEntryDiff 0.0 [] [] ))) :: b ) [] entries

getEntryDiff : StoreEntry -> StoreEntryDiff -> StoreEntryDiff
getEntryDiff a b =
  let
    convertDollars price =
      String.toFloat (String.dropLeft 1 price) |> Result.withDefault 0.0

    buildNewDiffItem item =
      let origItem = 
        List.filter (\or -> or.title == (fst item)) a.items |> List.head |> Maybe.withDefault (StoreItem "" "" Nothing)
      in
        case List.filter (\it -> it.title == (fst item)) b.items of
          [l] ->
            StoreItemDiff (l.title) (snd item) origItem.link "Price" (snd item - convertDollars l.price)
          [] ->
            StoreItemDiff (fst item) (snd item) origItem.link "New" 0.0
          _ ->
            StoreItemDiff (fst item) (snd item) origItem.link "New" 0.0

    setNameA = 
      Set.fromList <| List.map (\t -> ((t.title, convertDollars t.price))) a.items
    setNameB = 
      Set.fromList <| List.map (\t -> ((t.title, convertDollars t.price))) b.items

    diffNew = 
      Set.diff setNameA setNameB |> Set.toList
    diffLost = 
      Set.diff setNameB setNameA |> Set.filter ( \test -> not (List.any (\lItem -> lItem.title == fst test) a.items) ) |> Set.toList

    itemDiffNew = List.map buildNewDiffItem diffNew
    itemDiffLost = List.map (\t -> StoreItemDiff (fst t) (snd t) (Nothing) "Lost" 0.0) diffLost

  in
  StoreEntryDiff a.date (a.items) (itemDiffNew ++ itemDiffLost)

type alias StoreEntryDiff = {
  date: Float,
  items: List StoreItem,
  diff: List StoreItemDiff
}

storeEntryView : (Json.Encode.Value -> a) -> StoreEntryDiff -> Html a
storeEntryView act entry =
  let
      date = 
        Date.fromTime entry.date

  in 
      div [ class "entryItem card g--8 g-s--12" ] [
        div [ class "entryDate m-b--20" ] [
          a [ name <| "entry-date-" ++ toString entry.date ] []
        , span [] [ text <| format config "%B %-@d, %Y - %l:%M%p" date ]
        ]
      , if (List.length entry.diff > 0) then
          table [ class "storeItemDiffs" ]
          (List.map (storeItemDiffView act) entry.diff)
        else
          div [] [
            p [ class "m-t--20" ] [
              div [ class "d--inline m-r--10" ] [ text "No change since last entry "]
            , span [ class "tooltip maintenanceTooltip d--inline", Html.Attributes.attribute "data-text" "Usually this is because of a change in the code. Last known, adding links crawled from the store." ] [ 
                i [ class "zmdi zmdi-info" ] [] 
              ]
            ]
          ]
      , if (List.length entry.items > 0) then 
          div [ class "collapsible-wrap" ] [
            input [ Html.Attributes.type' <| "checkbox", id <| "collapsible-items-" ++ toString entry.date ] []
          , label [ for <| "collapsible-items-" ++ toString entry.date ] [ text "Full List" ]
          , div [ class <| "collapsible-items-" ++ toString entry.date ++ "-area" ] [ 
              table [ class "storeItems" ]
              (List.map (storeItemView act) entry.items)
            ]
          ]
        else
          div [] [ 
            p [ class "m-t--20" ] [ 
              text "All items removed - store empty. This is usually due to Kingdom Death Store Maintenance. " 
            , span [ class "tooltip maintenanceTooltip", Html.Attributes.attribute "data-text" "This is stored for historical reasons. I might remove these in the future." ] [ 
                i [ class "zmdi zmdi-info" ] [] 
              ]  
            ]
          ]
      ]

