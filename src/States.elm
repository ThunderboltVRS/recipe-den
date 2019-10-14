module States exposing (init, subscriptions)

import RemoteData
import Task
import Types exposing (..)
import RecipeDecoder

init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel flags, Cmd.none )


initialModel : Flags -> Model
initialModel flags =
    { recipeUrl = flags.recipeUrl
    , recipe = RecipeDecoder.decodeRecipe flags.stringifiedRecipe
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []