import String
import Window
import Json.Decode as Json exposing ((:=))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Graphics.Input.Field exposing (..)
import Graphics.Element exposing (Element, middle,container)


import Http
import Task exposing (..)

type alias Model =
  { title : String -- user's query string
  , result: String -- result from API
  }

                 
type Action = NoOp | Typing String | Search | Result String

                  
emptyModel : Model
emptyModel = { title = "", result = "" }

             
update : Action -> Model -> Model
update action m =
  case action of
    NoOp -> m
    Typing s -> { m | title = s }
    Search -> queryApi m
    Result s -> { m | title = s }


-- TODO rename?
queryApi : Model -> Model
queryApi m = { m | result = String.reverse m.title }               

             
movieSearch : Signal.Address Action -> Model -> Html
movieSearch address m =
  header
    [ id "header" ]
      [ h1 [] [ text "movies" ]
      , input
          [ id "movie-input"
          , placeholder "Enter a title"
          , autofocus True
          , value m.title
          , name "movieInput"
          , on "input" targetValue (Signal.message address << Typing)
          , onEnter address Search
          ]
            []
      , div [] [ text m.result ]
      ]


-- TODO comment
onEnter : Signal.Address a -> a -> Attribute
onEnter address v =
  on "keydown"
     (Json.customDecoder keyCode is13)
    (\_ -> Signal.message address v)

      
is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
     
        
-- view : Signal.Address Action -> Model -> Signal Element
view address model = movieSearch address model
{-  div [] [ movieSearch address model ] -}

                   
search : Signal.Mailbox Content
search = Signal.mailbox noContent

         
movie : Signal.Mailbox Action
movie = Signal.mailbox NoOp

        
model : Signal Model
model =
  Signal.foldp update emptyModel movie.signal


main : Signal Html
main =
  Signal.map (view movie.address) model


{-
results : Signal.Mailbox (Result String (List String))
results =
  Signal.mailbox (Err "Valid is 5 chars")

port requests : Signal (Task x ())
port requests =
  Signal.map lookupMovie movie.signal
    |> Signal.map (\task -> Task.toResult task `andThen` Signal.send results.address)
          
lookupMovie : String -> Task String (List String)
lookupMovie query =
  let toUrl = succeed ("http://api.zippopotam.us/us/" ++ query) in
  toUrl `andThen` (mapError (always "Not Found") << Http.get places)

places : Json.Decoder (List String)        
places =
  let place = Json.object2 (\city state -> city ++ ", " ++ state)
              ("place name" := Json.string)
              ("state" := Json.string)
  in "places" := Json.list place
-}

-- andThen : 
          {-
port runner : Task Http.Error ()
port runner = Http.getString "http://api.ipify.org/" `andThen` \s -> Signal.send movie.address (Result s)
-}

-- main = Signal.map Graphics.Element.show movie.signal

-- Signal.map : (a -> result) -> Signal a -> Signal result        
       
{-

movie : Signal.Mailbox Content
movie = Signal.mailbox noContent


movieField : Signal Element
movieField =
  Signal.map (field defaultStyle (Signal.message movie.address) "Movie") movie.signal


button : Signal.Mailbox Content
button = Signal.mailbox noContent

buttonField : Signal Element
buttonField =
  Signal.map (field defaultStyle (Signal.message button.address) "Button") button.signal


        
main : Signal Element
main = Signal.merge buttonField movieField
-}
