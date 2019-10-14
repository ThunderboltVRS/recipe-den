module RecipeDecoder exposing (decodeRecipe)

import Json.Decode
import Json.Decode.Pipeline exposing (required, optional)
import Json.Encode
import Types exposing (..)


decodeRecipe : String -> Maybe Recipe
decodeRecipe text =
    case Json.Decode.decodeString recipeDecoder text of
        Ok a ->
            Just a

        Err b ->
            let
                _ = Debug.log "Testing: " b
            in
                Nothing
            


recipeDecoder : Json.Decode.Decoder Recipe
recipeDecoder =
    Json.Decode.succeed Recipe
        |> required "@context" Json.Decode.string
        |> required "@type" Json.Decode.string
        |> required "name" Json.Decode.string
        |> required "image" (Json.Decode.list Json.Decode.string)
        |> required "author" decodeAuthor
        |> required "datePublished" Json.Decode.string
        |> required "description" Json.Decode.string
        |> required "prepTime" Json.Decode.string
        |> required "cookTime" Json.Decode.string
        |> required "totalTime" Json.Decode.string
        |> required "recipeYield" Json.Decode.string
        |> required "recipeCategory" Json.Decode.string
        |> required "recipeCuisine" Json.Decode.string
        |> required "keywords" Json.Decode.string
        |> optional "nutrition" (Json.Decode.map Just decodeNutrition) Nothing
        |> required "recipeIngredient" (Json.Decode.list Json.Decode.string)
        |> required "recipeInstructions" (Json.Decode.list decodeInstruction)
        |> optional "aggregateRating" (Json.Decode.map Just decodeAggregateRating) Nothing
        |> optional "review" (Json.Decode.map Just decodeReview) Nothing


decodeInstruction : Json.Decode.Decoder Instruction
decodeInstruction =
    Json.Decode.succeed Instruction
        |> required "@type" Json.Decode.string
        |> required "text" Json.Decode.string


decodeAuthor : Json.Decode.Decoder Author
decodeAuthor =
    Json.Decode.succeed Author
        |> required "@type" Json.Decode.string
        |> required "name" Json.Decode.string


decodeNutrition : Json.Decode.Decoder Nutrition
decodeNutrition =
    Json.Decode.succeed Nutrition
        |> required "@type" Json.Decode.string
        |> required "calories" Json.Decode.string


decodeAggregateRating : Json.Decode.Decoder AggregateRating
decodeAggregateRating =
    Json.Decode.succeed AggregateRating
        |> required "@type" Json.Decode.string
        |> required "ratingValue" Json.Decode.string
        |> required "ratingCount" Json.Decode.string


decodeReviewReviewRating : Json.Decode.Decoder ReviewReviewRating
decodeReviewReviewRating =
    Json.Decode.succeed ReviewReviewRating
        |> required "@type" Json.Decode.string
        |> required "ratingValue" Json.Decode.string
        |> required "bestRating" Json.Decode.string


decodeReviewAuthor : Json.Decode.Decoder ReviewAuthor
decodeReviewAuthor =
    Json.Decode.succeed ReviewAuthor
        |> required "@type" Json.Decode.string
        |> required "name" Json.Decode.string


decodeReview : Json.Decode.Decoder Review
decodeReview =
    Json.Decode.succeed Review
        |> required "@type" Json.Decode.string
        |> required "reviewRating" decodeReviewReviewRating
        |> required "author" decodeReviewAuthor
        |> required "datePublished" Json.Decode.string
        |> required "reviewBody" Json.Decode.string
        |> required "publisher" Json.Decode.string
