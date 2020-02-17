module LineRegex exposing
    ( all
    , day
    , log
    , month
    , setAccount
    , setDefaultAccount
    , setDefaultCurrency
    , setExchangeRate
    , year
    )

import Maybe exposing (withDefault)
import Regex exposing (Regex, fromString, fromStringWith)


sureRegex : Maybe Regex -> Regex
sureRegex =
    Maybe.withDefault Regex.never


simpleRegex : String -> Regex
simpleRegex str =
    sureRegex <| fromString str


caseInsensitiveRegex : String -> Regex
caseInsensitiveRegex str =
    sureRegex <|
        fromStringWith
            { caseInsensitive = True
            , multiline = False
            }
            str


year : Regex
year =
    simpleRegex "^[0-9]{4}$"


month : Regex
month =
    caseInsensitiveRegex "^(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)$"


day : Regex
day =
    simpleRegex "^[0-9]{1,2}$"


setDefaultAccount : Regex
setDefaultAccount =
    caseInsensitiveRegex <| "^default account (.*)"


setDefaultCurrency : Regex
setDefaultCurrency =
    caseInsensitiveRegex <| "^default currency (.*)"


setExchangeRate : Regex
setExchangeRate =
    caseInsensitiveRegex <| "^exchange rate (.*)"


setAccount : Regex
setAccount =
    caseInsensitiveRegex <| "^account (.*)"


log : Regex
log =
    caseInsensitiveRegex <| "^[0-9]+ ([^.]+)\\. (.+)"


summary : Regex
summary =
    caseInsensitiveRegex <| "^Summary"


all : Regex
all =
    sureRegex <| fromString "^.*$"
