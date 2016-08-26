module Load exposing (loadCourses)

import Http
import Json.Decode exposing (Decoder,(:=),list,string,int,object1,object6)
import Json.Decode.Extra exposing (date)
import Task exposing (..)
import Date exposing (Date)

import Model exposing (..)
import Msg exposing (..)


loadCourses : Cmd Msg
loadCourses =
  Task.perform LoadFailure SetCourses request


request : Task Http.Error (List Course)
request =
  -- Http.get courses "https://iversity.org/api/v1/courses.json" -- TODO CORS
  Http.get courses "json/courses.json"


courses : Decoder (List Course)
courses =
  "courses" :=
    list course


course : Decoder Course
course =
  object6
    Course
    ("title" := string)
    ("subtitle" := string)
    ("instructors" := list instructor)
    ("image" := string)
    ("start_date" := date)
    ("end_date" := date)


instructor : Decoder Instructor
instructor =
  object1
    Instructor
    ("name" := string)
