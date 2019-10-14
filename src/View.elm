module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick)
import Html.Events.Extra exposing (..)
import Json.Decode as Json
import RemoteData exposing (..)
import Types exposing (..)



view : Model -> Html Msg
view model =
    case model.recipe of
        Just recipe ->
            recipeDisplay recipe

        Nothing ->
            div [] [ text ("Loading: " ++ model.recipeUrl) ]


recipeDisplay : Recipe -> Html Msg
recipeDisplay recipe =
    div []
        [ heroSection recipe
        , div [ class "container" ]
            [ breadCrumbs recipe
            , detailsCard recipe
            , ingredientsCard recipe
            , instructionsGuide recipe
            ]
        ]


heroSection : Recipe -> Html Msg
heroSection recipe =
    section [ class "hero is-info" ]
        [ div [ class "hero-body" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ]
                    [ text recipe.name ]
                , h2 [ class "subtitle" ]
                    [ text recipe.description ]
                ]
            ]
        ]


breadCrumbs : Recipe -> Html Msg
breadCrumbs recipe =
    nav [ class "breadcrumb" ]
        [ ul []
            [ li []
                [ a [ href "#", onClick GoHome ]
                    [ text "Home" ]
                ]
            , li []
                [ a [ href "#" ]
                    [ text recipe.name ]
                ]
            ]
        ]


ingredientsCard : Recipe -> Html Msg
ingredientsCard recipe =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ p [ class "title" ]
                [ text "Ingredients" ]
            , ul [] (List.map (\i -> ingredientItem i) recipe.ingredients)
            ]
        ]


ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [] [ text ingredient ]


instructionsGuide : Recipe -> Html Msg
instructionsGuide recipe =
    div [ class "card" ]
        [ div [ class "card-content" ]
            [ p [ class "title" ]
                [ text "Steps" ]
            , ol [] (List.map (\i -> instructionItem i) recipe.instructions)
            ]
        ]


instructionItem : Instruction -> Html Msg
instructionItem instruction =
    li [] [ text instruction.text ]


detailsCard : Recipe -> Html Msg
detailsCard recipe =
    div [ class "card" ]
        [ div [ class "columns" ]
            [ div [ class "column" ]
                [ div [ class "card-image" ]
                    [ figure [ class "image is-5by4" ]
                        [ img [ src (Maybe.withDefault "" (List.head recipe.image)), alt "Placeholder image" ]
                            []
                        ]
                    ]
                ]
            , div [ class "card-content" ]
                [ div [ class "media" ]
                    [ div [ class "media-left" ]
                        [ figure [ class "image is-2by1" ]
                            [ img [ src "https://bulma.io/images/placeholders/96x96.png", alt "Placeholder image" ]
                                []
                            ]
                        ]
                    , div [ class "section" ]
                        [ strong [] [ text "Cook Time: " ]
                        , text recipe.cookTime
                        ]
                    , div [ class "section" ]
                        [ strong [] [ text "Prep Time: " ]
                        , text recipe.prepTime
                        ]
                    ]
                ]
            ]
        ]
