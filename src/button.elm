import Html exposing (div, button, text, input)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp


main =
  StartApp.start { model = model, view = view, update = update }


model = 0


view address model =
  div []
    [ input [ placeholder "Enter Movie Query"

            ]
        [ ]
    , button [ onClick address Search ] [text "Search "]
  ]


type Action = Search


update action model = 0
