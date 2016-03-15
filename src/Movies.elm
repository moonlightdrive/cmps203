module Movies where
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
import Effects exposing (Effects, Never)


type alias Movie =
  { title: String
  , poster: String -- an img url
  , year: String
  , plot: String
  }

                     
type alias Model =
  { title : String  -- user's query string (a movie title)
  , result : Movie -- result from API
  }

type Action = NoOp | Typing String | Search | UpdateResults (Maybe Movie)


emptyMovie = { poster = ""
             , title = ""
             , year = ""
             , plot = ""
             }
            

init : String -> (Model, Effects Action)
init s = ( Model s emptyMovie, getReqResults s)


update : Action -> Model -> (Model, Effects Action)
update action m =
  case action of
    NoOp -> (m, Effects.none)
    Typing s -> ({ m | title = s }, Effects.none)
    Search -> (m, getReqResults m.title)
    UpdateResults maybeUrl -> (Model m.title (Maybe.withDefault m.result maybeUrl), Effects.none)

                              
getReqResults : String -> Effects Action
getReqResults title =
  Http.get decodeUrl (api title)
      |> Task.toMaybe
      |> Task.map UpdateResults
      |> Effects.task

api : String -> String
api title = Http.url "http://omdbapi.com/" [ ("t", title), ("plot", "full") ]


decodeUrl : Json.Decoder Movie
decodeUrl = Json.object4 Movie ("Title" := Json.string) ("Poster" := Json.string) ("Year" := Json.string)  ("Plot" := Json.string)


-- Can also query the API with a search to return multiple movies            
{-
decodeUrl : Json.Decoder (List Movie)
decodeUrl = "Search" := Json.list movie_json

            
movie_json : Json.Decoder Movie
movie_json = Json.object2 Movie
             ("Title" := Json.string)
             ("Poster" := Json.string)
-}
            
movieSearch : Signal.Address Action -> Model -> Html
movieSearch address m =
  header
    [ id "header" ] <|
      [ h1 [] [ text "movies" ]
      , input
          [ id "movie-input"
          , placeholder "Enter a title"
          , autofocus True
          , value m.title
          , name "movieInput"
          , on "input" targetValue (Signal.message address << Typing)
          , onEnter address Search
          ] []
      , button [ onClick address Search ] [text "Go!"]
      , section [ id "movie_result" ] [ movieDiv m.result ]
      ]

      
formatMovies : List Movie -> List Html
formatMovies = List.map (\m -> movieDiv m)


movieDiv : Movie -> Html       
movieDiv m = div [] [ h2 [] [text (m.title ++ " (" ++ m.year ++")")]
                    , movieImg m.poster
                    , p [] [text m.plot]
                    ]
movieImg : String -> Html
movieImg url = if url == "N/A" then span [] [] else img [ src url ] []              


-- This function was defined in the Elm docs/tutorial
onEnter : Signal.Address a -> a -> Attribute
onEnter address v =
  on "keydown"
     (Json.customDecoder keyCode is13)
    (\_ -> Signal.message address v)

-- This function was defined in the Elm docs/tutorial
is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
     

view : Signal.Address Action -> Model -> Html
view address model = movieSearch address model
