import Movies exposing (..)

import Effects exposing (Never)
import Task
import StartApp exposing (start) -- startapp is a wrapper around Elm's signals!

app =
  StartApp.start { init = init "The Lion King"
                 , update = update
                 , view = view
                 , inputs = []
                 }

main =
  app.html
    
port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
