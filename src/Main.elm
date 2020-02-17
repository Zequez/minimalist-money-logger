module Main exposing (..)

import Browser
import Cx exposing (c)
import Html exposing (Html, button, div, h1, h2, img, main_, section, span, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import LineRegex
import List.Extra
import Maybe
import Regex exposing (Match, Regex)
import Time exposing (Month, Posix)



----------------- ELEMENTAL TYPES


type alias AccountName =
    String


type Currency
    = USD
    | ARS


type alias ExchangeRate =
    ( Currency, Currency, Float )



----------------- LINE VARIETY TYPES


type LineVariety
    = Log -- LogConfig
    | Summary -- SummaryConfig
    | SetDefaultAccount -- AccountName
    | SetDefaultCurrency -- Currency
    | SetAccount -- Account
    | SetYear -- Int
    | SetMonth -- Month
    | SetDay -- Int
    | SetExchangeRate -- ExchangeRate
    | Undetermined


type alias LogConfig =
    { day : Int
    , description : String
    , fromAccount : Maybe AccountName
    , toAccount : AccountName
    , fromMoney : Float
    , toMoney : Maybe Float
    }


type alias SummaryConfig =
    { from : Posix
    , to : Posix
    , collapsed : Bool
    }



----------------- LINE TYPE


type alias Line =
    { id : Int
    , text : String
    , variety : LineVariety
    }



----------------- POST PROCESSING TYPES


type alias Account =
    { name : AccountName
    , money : Float
    , currency : Currency
    , own : Bool
    , automatic : Bool
    }


type alias ExpandedLog =
    { date : Posix
    , description : String
    , movements : List Movement
    }


type alias Movement =
    { account : AccountName
    , money : Float
    }


type alias SummaryResult =
    { accountsDiff : List Account
    , latestSettings : SettingsUpToNow
    }


type alias SettingsUpToNow =
    { accounts : List Account
    , defaultAccountName : Maybe AccountName
    , defaultCurrency : Maybe Currency
    , year : Maybe Int
    , month : Maybe Month
    , exchangeRates : List ExchangeRate
    }


type LineResult
    = LineError
    | LineNothing



----------------- MODEL TYPE


type alias Model =
    { lines : List Line
    }



----------------- UTILS


summaryProcessor : SettingsUpToNow -> List Line -> SummaryResult
summaryProcessor settings lines =
    { accountsDiff = settings.accounts
    , latestSettings = settings
    }


processLine : Line -> LineResult
processLine line =
    case line.variety of
        Log ->
            LineNothing

        Summary ->
            LineNothing

        SetDefaultAccount ->
            LineNothing

        SetDefaultCurrency ->
            LineNothing

        SetAccount ->
            LineNothing

        SetYear ->
            LineNothing

        SetMonth ->
            LineNothing

        SetDay ->
            LineNothing

        SetExchangeRate ->
            LineNothing

        Undetermined ->
            LineNothing


detectLineVariety : String -> LineVariety
detectLineVariety text =
    case
        matchFirst text
            [ ( LineRegex.log, Log )
            , ( LineRegex.year, SetYear )
            , ( LineRegex.month, SetMonth )
            , ( LineRegex.day, SetDay )
            , ( LineRegex.setDefaultAccount, SetDefaultAccount )
            , ( LineRegex.setDefaultCurrency, SetDefaultCurrency )
            , ( LineRegex.setAccount, SetAccount )
            , ( LineRegex.setExchangeRate, SetExchangeRate )
            , ( LineRegex.all, Undetermined )
            ]
    of
        ( Log, matches ) ->
            Log

        ( Summary, matches ) ->
            Summary

        ( SetDefaultAccount, matches ) ->
            SetDefaultAccount

        ( SetDefaultCurrency, matches ) ->
            SetDefaultCurrency

        ( SetAccount, matches ) ->
            SetAccount

        ( SetYear, matches ) ->
            SetYear

        ( SetMonth, matches ) ->
            SetMonth

        ( SetDay, matches ) ->
            SetDay

        ( SetExchangeRate, matches ) ->
            SetExchangeRate

        ( Undetermined, matches ) ->
            Undetermined


matchFirst : String -> List ( Regex, LineVariety ) -> ( LineVariety, List Match )
matchFirst text regexList =
    regexList
        |> List.Extra.find (\( regex, lineVariety ) -> Regex.contains regex text)
        |> Maybe.withDefault ( Regex.never, Undetermined )
        |> (\( regex, lineVariety ) -> ( lineVariety, Regex.find regex text ))


rawExampleLines : List String
rawExampleLines =
    [ "2019"
    , "Feb"
    , "Default Account Efectivo"
    , "Default Currency ARS"
    , "Account Efectivo 1000ARS own"
    , "Exchange Rate 1USD -> 61.30ARS"
    , "16"
    , "300 Frutas y verduras. Almacén Rubén"
    , "Summary"
    ]


generateExampleLines : List Line -> List Line
generateExampleLines lines =
    rawExampleLines
        |> List.foldr
            (\str result ->
                lineFromText str result :: result
            )
            lines


lineFromText : String -> List Line -> Line
lineFromText text lines =
    { id = nextId lines
    , text = text
    , variety = detectLineVariety text
    }


nextId : List Line -> Int
nextId lines =
    List.foldl
        (\line maxId ->
            if line.id > maxId then
                line.id

            else
                maxId
        )
        1
        lines



----------------- INIT


init : ( Model, Cmd Msg )
init =
    ( { lines = [] }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = AddExampleLines



-- | AddNewLine
-- | UpdateNewLine


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddExampleLines ->
            ( { model
                | lines =
                    List.concat
                        [ model.lines
                        , generateExampleLines model.lines
                        ]
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ section [ c "hero is-primary is-bold" ]
            [ div [ c "hero-body has-text-centered" ]
                [ div [ c "container" ]
                    [ h1 [ c "title" ] [ text "Minimalist Money Logger" ]
                    , h2 [ c "subtitle" ] [ text "It's so simple you actually stick with it" ]
                    ]
                ]
            ]
        , main_ [ c "section" ]
            [ div [ c "container" ]
                [ if List.isEmpty model.lines then
                    button
                        [ c "button is-large is-fullwidth is-primary"
                        , onClick AddExampleLines
                        ]
                        [ text "Start" ]

                  else
                    linesView model.lines
                ]
            ]
        ]


linesView : List Line -> Html Msg
linesView lines =
    div [ c "" ]
        (lines
            |> List.map lineView
        )


lineView : Line -> Html Msg
lineView line =
    div []
        [ span [ c "tag is-light" ]
            [ text (lineVarietyToText line.variety) ]
        , text
            line.text
        ]


lineVarietyToText : LineVariety -> String
lineVarietyToText lineVariety =
    case lineVariety of
        Log ->
            "Log"

        Summary ->
            "Summary"

        SetDefaultAccount ->
            "SetDefaultAccount"

        SetDefaultCurrency ->
            "SetDefaultCurrency"

        SetAccount ->
            "SetAccount"

        SetYear ->
            "SetYear"

        SetMonth ->
            "SetMonth"

        SetDay ->
            "SetDay"

        SetExchangeRate ->
            "SetExchangeRate"

        Undetermined ->
            "Undetermined"



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
