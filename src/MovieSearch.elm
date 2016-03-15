-- declares that this is the MovieSearch module, which is how
-- other modules will reference this one if they want to import it and reuse its code.
module MovieSearch where

-- The “exposing (..)” option specifies that we want to bring the Html module’s contents
-- into this file’s current namespace, so that instead of writing out
-- Html.form and Html.label we can just use "form" and "label" without the "Html." prefix.
import Html exposing (..)
import Html.Events exposing (..)

-- With this import we are only bringing a few specific functions into our
-- namespace, specifically "id", "type'", "for", "value", and "class".
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

--foldp is a signal dependent on the past 
model : Signal Model
model = Signal.foldp update init actions.signal


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


-- VIEW

view : Model -> Html
view model =
  div [ class "box" ]
  [ h2 [] [ text "Please click on your favorite image or enter your movie search" ]
   , img [ alt "Mountain View", src "http://elm-lang.org/imgs/yogi.jpg", attribute "style" "width:304px;height:228px;" ]
  [ ]
   , label [ ] [ text "username: " ]
   , div [ attribute "role" "form" ]
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
  
  
