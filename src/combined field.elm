import Html exposing (..)
import Html.Attributes exposing (..) 
--action, attribute, class, for, id, type

-- MODEL

type Model =
  Undefined


init : Model
init =
  Undefined


-- UPDATE

type Action
  = NoOp


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model


-- SIGNALS

main : Signal Html
main =
  Signal.map view model


model : Signal Model
model = Signal.foldp update init actions.signal


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


-- VIEW

view : Model -> Html
view model =
  div [ class "box" ]
  [ div [ attribute "role" "form" ]
    [ div [ class "form-group" ]
      [ label [ for "Genre" ]
        [ text "Genre" ]
      , input [ id "Genre", type' "text" , class "form-control" ]
        []
      ]
    , div [ class "form-group" ]
      [ label [ for "Actor" ]
        [ text "Actor" ]
      , input [ id "Actor", type' "text" , class "form-control" ]
        []
      ]
    , div [ class "form-group" ]
      [ label [ for "Actress" ]
        [ text "Actress" ]
      , input [ id "Actress", type' "text" , class "form-control" ]
        []
      ]
    , button [ class "btn btn-default" ]
      [ text "Search" ]
    ]
  ]
  
  