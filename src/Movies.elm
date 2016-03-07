import Graphics.Input.Field exposing (..)
import Graphics.Element exposing (Element)


movie : Signal.Mailbox Content
movie = Signal.mailbox noContent


movieField : Signal Element
movieField =
  Signal.map (field defaultStyle (Signal.message movie.address) "Movie") movie.signal


main : Signal Element
main = movieField
