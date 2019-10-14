module Update exposing (update)

import Date
import DatePicker
import RemoteData exposing (WebData)
import Types exposing (..)
import Ports exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        GoHome ->
            ( model, goHome "" )
