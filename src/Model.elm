module Model exposing (..)


type alias Model =
  { courses : List Course }

type alias Course =
  { title : String }


initialModel : Model
initialModel =
  { courses = [] }
