import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import Graphics.Input.Field exposing (..)
import Graphics.Element exposing (Element)
import StartApp.Simple as StartApp


movie : Signal.Mailbox Content
movie = Signal.mailbox noContent

movieField : Signal Element
movieField =
  Signal.map (field defaultStyle (Signal.message movie.address) "Movie") movie.signal

main : Signal Element
main = movieField

--main =
--  StartApp.start { model = model, view = view, update = update }

model = 0


view address model =
  div []
    [ button [ onClick address Search ] [ text "Search" ]

  ]

type Action = Search


update action model = 0