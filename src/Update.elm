module Update exposing (update)

import Ports exposing (..)
import Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        GoHome ->
            ( model, goHome "" )

        IngredientChecked ingredient ->
            ( { model | recipe = updateIngredientState model.recipe ingredient }, Cmd.none )


updateIngredientState : Maybe Recipe -> Ingredient -> Maybe Recipe
updateIngredientState mRecipe ingredient =
    case mRecipe of
        Just recipe ->
            Just
                { recipe
                    | ingredients =
                        List.map
                            (\i ->
                                if i.name == ingredient.name then
                                    ingredientChecked i

                                else
                                    i
                            )
                            recipe.ingredients
                }

        Nothing ->
            Nothing


ingredientChecked : Ingredient -> Ingredient
ingredientChecked ingredient =
    case ingredient.state of
        Pending ->
            { ingredient | state = Ready }

        Ready ->
            { ingredient | state = Pending }
