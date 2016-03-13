import Html exposing (..)
import Html.Attributes exposing (action, attribute, class, for, id, type')


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
  div [ class "container" ]
  [ div [ attribute "role" "form" ]
    [ div [ class "form-group" ]
      [ label [ for "name" ]
        [ text "name" ]
      , input [ id "name", type' "text" , class "form-control" ]
        []
      ]
    , div [ class "form-group" ]
      [ label [ for "age" ]
        [ text "age" ]
      , input [ id "age", type' "text" , class "form-control" ]
        []
      ]
    , button [ class "btn btn-default" ]
      [ text "Submit" ]
    ]
  ]
