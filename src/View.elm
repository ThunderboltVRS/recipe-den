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
        , div [ class "container is-fluid block" ] [ div [ class "container" ] [ breadCrumbs recipe ] ]
        , div [ class "container block is-fluid main-section" ]
            [ div [ class "container box mb-4" ]
                [ div [ class "columns" ]
                    [ div [ class "column" ] [ detailsCard recipe ]
                    , div [ class "column" ] [ ingredientsCard recipe ]
                    , div [ class "column" ] [ instructionsGuide recipe ]
                    ]
                ]
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
                [ a [ href "/" ]
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
    div [ class "container" ]
        [ p [ class "title" ]
            [ text "Ingredients" ]
        , div [ class "form" ] [ ul [] (List.map (\i -> ingredientItem i) recipe.ingredients) ]
        ]


ingredientItem : String -> Html Msg
ingredientItem ingredient =
    li [ class "control" ]
        [ label [ class "checkbox" ]
            [ input [ Html.Attributes.type_ "checkbox" ] []
            , text ingredient
            ]
        ]


instructionsGuide : Recipe -> Html Msg
instructionsGuide recipe =
    div [ class "container" ]
        [ p [ class "title" ]
            [ text "Steps" ]
        , ol [] (List.map (\i -> instructionItem i) recipe.instructions)
        ]


instructionStepId : Instruction -> String
instructionStepId instruction =
    String.split "#" instruction.text
        |> List.tail
        |> Maybe.withDefault []
        |> List.head
        |> Maybe.withDefault ""


instructionItem : Instruction -> Html Msg
instructionItem instruction =
    li [ id (instructionStepId instruction) ] [ text instruction.text ]



friendlyDuration : String -> String
friendlyDuration duration =
    String.replace "PT" "" duration
        |> String.replace "M" " minutes"
        |> String.replace "H" " hours"


summaryCard : Recipe -> Html Msg
summaryCard recipe =
    div [ class "container " ]
        [ div [ class "container" ]
            [ p []
                [ strong [] [ text "Cook Time: " ]
                , text (friendlyDuration recipe.cookTime)
                ]
            , p []
                [ strong [] [ text "Prep Time: " ]
                , text (friendlyDuration recipe.prepTime)
                ]
            ]
        ]


detailsCard : Recipe -> Html Msg
detailsCard recipe =
    div [ class "container" ]
        [ div [ class "card-image" ]
            [ figure [ class "image is-5by4" ]
                [ img [ src (Maybe.withDefault "" (List.head recipe.image)), alt "Placeholder image" ]
                    []
                ]
            ]
        , summaryCard recipe
        ]
