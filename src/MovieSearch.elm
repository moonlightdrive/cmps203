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
    , img [ alt "Actor", src "http://www.puppyheaven.com/media/imagegallery/leonardo-dicaprio-celebrity-gallery-img-2015-12-24-21-28-18.jpg", attribute "style" "width:300px;height:300px;" ]
  [ ]
  , img [ alt "Actor", src "http://susers.thatsmyface.com/d/dburnsii/Will_Smith_front_cYkveOBguJ-largeThumb_4b67985e.jpg", attribute "style" "width:300px;height:300px;" ]
  [ ]
  , img [ alt "Actor", src "http://hairstyles.thehairstyler.com/hairstyle_views/front_view_images/1869/original/Matt-Damon.jpg", attribute "style" "width:300px;height:300px;" ]
  [ ]
  
    , div [  ]
      [ label [ for "Genre" ]
        [ text "Genre" ]
      , input [ id "Genre", type' "text"  ]
        []
      ]
      
    , div [  ]
      [ label [ for "Actor" ]
        [ text "Actor" ]
      , input [ id "Actor", type' "text"  ]
        []
      ]
      
    , div [ ]
      [ label [ for "Actress" ]
        [ text "Actress" ]
      , input [ id "Actress", type' "text"  ]
        []
      ]
      
    , button [  ]
      [ text "Search" ]
    ]
  
  
