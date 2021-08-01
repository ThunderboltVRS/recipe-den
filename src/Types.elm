module Types exposing (AggregateRating, Author, Flags, Ingredient, IngredientState(..), Instruction, Model, Msg(..), Nutrition, Recipe, Review, ReviewAuthor, ReviewReviewRating)

import Http
import RemoteData exposing (WebData)
import Time


type Msg
    = None
    | GoHome
    | IngredientChecked Ingredient


type alias Model =
    { recipeUrl : String
    , recipe : Maybe Recipe
    }


type alias Flags =
    { recipeUrl : String
    , stringifiedRecipe : String
    }


type IngredientState
    = Pending
    | Ready


type alias Ingredient =
    { name : String
    , state : IngredientState
    }


type alias Recipe =
    { context : String
    , recipeType : String
    , name : String
    , image : List String
    , author : Author
    , datePublished : String
    , description : String
    , prepTime : String
    , cookTime : String
    , totalTime : String
    , recipeYield : String
    , recipeCategory : String
    , recipeCuisine : String
    , keywords : String
    , nutrition : Maybe Nutrition
    , ingredients : List Ingredient
    , instructions : List Instruction
    , aggregateRating : Maybe AggregateRating
    , review : Maybe Review
    }


type alias Author =
    { authorType : String
    , name : String
    }


type alias Instruction =
    { instructionType : String
    , text : String
    , url : String
    , image : String
    , name : String
    }


type alias Nutrition =
    { nutritionType : String
    , calories : String
    }


type alias AggregateRating =
    { aggregateType : String
    , ratingValue : String
    , ratingCount : String
    }


type alias ReviewReviewRating =
    { reviewType : String
    , ratingValue : String
    , bestRating : String
    }


type alias ReviewAuthor =
    { reviewAuthorType : String
    , name : String
    }


type alias Review =
    { reviewType : String
    , reviewRating : ReviewReviewRating
    , author : ReviewAuthor
    , datePublished : String
    , reviewBody : String
    , publisher : String
    }



-- type alias RecipeProgress
--     {
--     }
