port module StoreWatchElm exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Encode exposing (..)
import Json.Decode exposing (..)
import StoreEntry exposing (..)
import StoreEntryDiff exposing (..)


-- Setup the main import

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { 
    formNumber: String
  , entries: List StoreEntryDiff
  }

decodeEntries : Decoder (List StoreEntry)
decodeEntries = 
  Json.Decode.list decodeStoreEntry

init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)


-- UPDATE

type Msg
  = Update Json.Decode.Value
  | Action Json.Encode.Value
  | UpdateNumber String

port action : String -> Cmd msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Update newEntries ->
      ( Json.Decode.decodeValue decodeEntries newEntries 
        |> Result.withDefault [] 
        |> diffAllEntries 
        |> Model "", Cmd.none )
    Action object ->
      ( model, encode 0 object |> action ) -- create flat json string for export - encode 0 just makes unpretty json
    UpdateNumber str ->
      ( { model | formNumber = str }, Cmd.none )

port entries : (Json.Decode.Value -> msg) -> Sub msg

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ entries Update
  ]

-- VIEW

-- Functions

view : Model -> Html Msg
view model =
  let 
    submitMsg val = Json.Encode.object [
      ("type", Json.Encode.string "SubmitMobile")
    , ("number", Json.Encode.string val) ]

  in
    div [ class "kingdomDeathStore" ]
      [ 
        div [ class "header text-left p-l-10 clearfix" ] [
          h2 [ class "c-black left g--6 g-s--6 g-t--12 no-margin" ] [ text "Kingdom Death Store Tracker" ]
        , Html.form [ class "left g--4 g-s--6 g-t--12 no-margin", onSubmit <| Action <| submitMsg model.formNumber ] [
            label [ 
              for "kdmMobileNotification"
            , class "d--block" ] [ 
              text "Enter your phone number to be notified by text when the Kingdom Death Store updates." ]
          , div [ class "", style [("margin-top","10px"), ("margin-bottom","10px")] ] [
              input [ 
                type' "text"
              , class "d--inline m-r--20"
              , id "kdmMobileNotification"
              , Html.Attributes.value model.formNumber
              , onInput UpdateNumber ] []
            , button [ type' "submit", class "mobileSubmitBtn btn-raised d--inline bg--teal color--white" ] [ text "Send" ]
            ]
          ]
        ]
      , div [ class "description clearfix g--8 g-s--12" ] [
          p [ class "description" ] [
            text "The Lantern Hoard Store Watch was created to record and compare the storefront at "
          , a [ href "https://shop.kingdomdeath.com", target "_blank", rel "noopener noreferrer" ] [ text "shop.kingdomdeath.com" ]
          , text "."
          ]
        , p [ class "description" ] [
            text "Entries are shown newest first, and display the changes to the store. The Full List will show a snapshot of all items at that time."
          ]
        , p [ class "description" ] [
            text "Items with a "
          , i [ class "zmdi zmdi-plus color--nephritis" ] []
          , text " are new items, items with a "
          , i [ class "zmdi zmdi-minus color--alizarin" ] []
          , text " are removed items, and items with a ~ are changed items - if the price changes, the difference will be displayed as well."
          ]
        ]
      , div [ class "clearfix" ] ( List.map ( storeEntryView Action ) model.entries )
      ]

